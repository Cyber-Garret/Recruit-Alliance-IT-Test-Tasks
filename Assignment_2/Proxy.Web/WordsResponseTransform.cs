using Microsoft.Extensions.Primitives;

using Yarp.ReverseProxy.Transforms;
using Yarp.ReverseProxy.Transforms.Builder;

namespace Proxy.Web;

public class WordsResponseTransform : ITransformProvider
{
    private readonly IDecompressService _decompressService;

    public WordsResponseTransform(IDecompressService decompressService)
    {
        _decompressService = decompressService;
    }

    public void ValidateRoute(TransformRouteValidationContext context)
    {
        // Ignored. As result used for all Routes
    }

    public void ValidateCluster(TransformClusterValidationContext context)
    {
        // Ignored. As result used for all Clusters
    }

    public void Apply(TransformBuilderContext transformBuilder)
    {
        transformBuilder.AddXForwardedFor();
        transformBuilder.AddXForwardedProto();
        transformBuilder.AddResponseTransform(async context =>
        {
            if (context.ProxyResponse == null)
                return;

            var contentByteArray = await context.ProxyResponse.Content.ReadAsByteArrayAsync();
            var contentEncoding = context.ProxyResponse?.Content.Headers.ContentEncoding;
            var content = await _decompressService.DecompressData(contentEncoding, contentByteArray);

            if (!string.IsNullOrEmpty(content))
            {
                context.SuppressResponseBody = true;

                content = await content.ReplaceWord();
                var bytes = Encoding.UTF8.GetBytes(content);

                // Change Content-Length to match the modified body, or remove it.
                context.HttpContext.Response.ContentLength = bytes.Length;

                // Response headers are copied before transforms are invoked, update any needed headers on the HttpContext.Response.
                context.HttpContext.Response.Headers.ContentEncoding = StringValues.Empty;
                await context.HttpContext.Response.Body.WriteAsync(bytes);
            }
        });
    }
}