using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.Extensions;
using Microsoft.AspNetCore.Http.Internal;
using Newtonsoft.Json;
using SqlD.Network.Client;
using SqlD.Network.Server.Api.Db.Model;

namespace SqlD.Network.Server.Middleware
{
	public class ForwardingMiddleware
	{
		private readonly EndPoint[] forwardAddresses;

		public ForwardingMiddleware(params EndPoint[] forwardAddresses)
		{
			this.forwardAddresses = forwardAddresses;
		}

		public async Task InvokeAsync(HttpContext context, Func<Task> next)
		{
			StreamReader streamReader = null;
			if (forwardAddresses.Any())
			{
				BeforeInvoke_BeforeRequestRead(context);

				try
				{
					if (context.Request.GetDisplayUrl().ToLower().Contains("/api/db/command"))
					{
						streamReader = new StreamReader(context.Request.Body);
						var commandRequest = Deserialise<Command>(streamReader);
						await ForwardToClients(async client => await client.PostCommandAsync(commandRequest));
					}

					if (context.Request.GetDisplayUrl().ToLower().Contains("/api/db/scalar"))
					{
						streamReader = new StreamReader(context.Request.Body);
						var commandRequest = Deserialise<Command>(streamReader);
						await ForwardToClients(async client => await client.PostScalarAsync(commandRequest));
					}
				}
				catch (Exception err)
				{
					Logging.Log.Out.Error(err.ToString());
				}

				BeforeInvoke_AfterRequestRead(context);
			}
			await next.Invoke();
			streamReader?.Dispose();
		}

		private async Task ForwardToClients(Func<ConnectionClient, Task<CommandResponse>> clientApiCall)
		{
			foreach (var forwardAddress in forwardAddresses)
			{
				try
				{
					var client = SqlDStart.NewClient().ConnectedTo(forwardAddress);

					var commandResponse = await clientApiCall(client);
					if (commandResponse.StatusCode != StatusCode.Ok)
					{
						Logging.Log.Out.Error($"Replicated to {forwardAddress} with {commandResponse.Error}");
					}
				}
				catch (Exception err)
				{
					Logging.Log.Out.Error(err.ToString());
				}
			}
		}

		public void BeforeInvoke_BeforeRequestRead(HttpContext context)
		{
			context.Request.EnableRewind();
		}

		public void BeforeInvoke_AfterRequestRead(HttpContext context)
		{
			context.Request.Body.Position = 0;
		}

		private static T Deserialise<T>(StreamReader bodyRequeStreamReader)
		{
			var body = bodyRequeStreamReader.ReadToEnd();
			var request = JsonConvert.DeserializeObject<T>(body);
			return request;
		}
	}
}