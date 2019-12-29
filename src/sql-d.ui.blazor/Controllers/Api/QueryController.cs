using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using SqlD.UI.Services;

namespace SqlD.UI.Blazor.Controllers.Api
{
    [ApiController]
	[Route("api/[controller]")]
	public class QueryController : Controller
	{
		private readonly QueryService queryService;

		public QueryController(QueryService queryService)
		{
			this.queryService = queryService;
		}

		[HttpGet("{q}/{s}")]
		public virtual async Task<IActionResult> Get([FromRoute] string q, [FromRoute] string s)
		{
			var value = await queryService.Query(q, WebUtility.UrlDecode(s), HttpContext, cacheResult:false);
			return Ok(value);
		}
	}
}