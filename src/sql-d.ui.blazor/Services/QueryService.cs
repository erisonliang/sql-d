using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using SqlD.UI.Services.Client;
using SqlD.UI.Services.Query;
using SqlD.UI.Services.Query.Actions;

namespace SqlD.UI.Services
{
	public class QueryService
	{
		private readonly ConfigService config;
		private readonly RegistryService registry;
		private readonly ClientFactory clients;
		private readonly QueryCache cache;
		private readonly IQueryAction unknownAction;
		private readonly IQueryAction describeAction;
		private readonly IQueryAction commandAction;
		private readonly IQueryAction queryAction;
		private readonly ContextService context;

		public QueryService(ContextService context, ConfigService configService, RegistryService registryService, ClientFactory clientFactory, UnknownAction unknownAction, DescribeAction describeAction, CommandAction commandAction, QueryAction queryAction)
		{
			this.context = context ?? throw new ArgumentNullException(nameof(context));
			this.cache = cache ?? throw new ArgumentNullException(nameof(cache));
			this.config = configService ?? throw new ArgumentNullException(nameof(configService));
			this.registry = registryService ?? throw new ArgumentNullException(nameof(registryService));
			this.clients = clientFactory ?? throw new ArgumentNullException(nameof(clientFactory));
			this.unknownAction = unknownAction ?? throw new ArgumentNullException(nameof(unknownAction));
			this.describeAction = describeAction ?? throw new ArgumentNullException(nameof(describeAction));
			this.commandAction = commandAction ?? throw new ArgumentNullException(nameof(commandAction));
			this.queryAction = queryAction ?? throw new ArgumentNullException(nameof(queryAction));
		}

		public async Task<object> Query(string query, string targetUri = null, HttpContext httpContext = null, bool cacheResult = true)
		{
			var queryContext = new QueryContext(query, targetUri, httpContext);

			if (cacheResult)
			{
				var cache = new QueryCache(context);
				if (cache.HasQueryResult())
					return cache.GetQueryResult();

				var queryResult = await GetQueryResult(queryContext);
				return cache.SetQueryResult(queryResult);
			}

			return await GetQueryResult(queryContext);
		}
		private async Task<object> GetQueryResult(QueryContext context)
		{
			var client = clients.GetClientOrDefault(context, config);

			return await context.If(QueryToken.DESCRIBE, async () => await describeAction.Go(context, client, registry))
				?? await context.If(QueryToken.SELECT, async () => await queryAction.Go(context, client, registry))
				?? await context.If(QueryToken.INSERT, async () => await commandAction.Go(context, client, registry))
				?? await context.If(QueryToken.UPDATE, async () => await commandAction.Go(context, client, registry))
				?? await context.If(QueryToken.DELETE, async () => await commandAction.Go(context, client, registry))
				?? await context.If(QueryToken.CREATE, async () => await commandAction.Go(context, client, registry))
				?? await context.If(QueryToken.ALTER, async () => await commandAction.Go(context, client, registry))
				?? await context.If(QueryToken.DROP, async () => await commandAction.Go(context, client, registry))
				?? await unknownAction.Go(context, client, registry);
		}
	}
}