using Microsoft.AspNetCore.Http;
using SqlD.Network;

namespace SqlD.UI.Services.Extensions
{
    public static class EndPointExtensions
    {
        public static string GetRedirectedUri(this EndPoint endPoint, IHttpContextAccessor accessor)
        {
            var request = accessor.HttpContext.Request;
            
            if (endPoint.Host.ToLower() == "localhost")
            {
                return $"{request.Scheme}://{request.Host.Host}:{endPoint.Port}/";
            }

            return endPoint.ToUrl();
        }
        
        public static string GetRedirectedUri(this string uri, IHttpContextAccessor accessor)
        {
            var endPoint = EndPoint.FromUri(uri);
            var request = accessor.HttpContext.Request;
            
            if (endPoint.Host.ToLower() == "localhost")
            {
                return $"{request.Scheme}://{request.Host.Host}:{endPoint.Port}/";
            }

            return endPoint.ToUrl();
        }

    }
}