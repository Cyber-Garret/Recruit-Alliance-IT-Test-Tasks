using System.IO.Compression;

namespace Proxy.Web.Services;

public class DecompressService : IDecompressService
{
    public async Task<string> DecompressData(ICollection<string>? contentEncoding, byte[] data)
    {
        using var memoryStream = new MemoryStream(data);
        if (contentEncoding == null || contentEncoding.Count == 0)
        {
            using var asIsreader = new StreamReader(memoryStream);
            var body = await asIsreader.ReadToEndAsync();
            return body;
        }

        var decompressionStream = GetDecompressionStream(contentEncoding, memoryStream);
        if (decompressionStream == null)
            return string.Empty;

        using var reader = new StreamReader(decompressionStream);
        var decompressedBody = await reader.ReadToEndAsync();
        return decompressedBody;
    }

    private static Stream? GetDecompressionStream(ICollection<string>? contentEncoding,
        Stream memoryStream)
    {
        if (IsContainsEncoding(contentEncoding, "gzip"))
            return new GZipStream(memoryStream, CompressionMode.Decompress);
        if (IsContainsEncoding(contentEncoding, "deflate"))
            return new DeflateStream(memoryStream, CompressionMode.Decompress);
        if (IsContainsEncoding(contentEncoding, "br"))
            return new BrotliStream(memoryStream, CompressionMode.Decompress);
        return null;
    }

    private static bool IsContainsEncoding(ICollection<string>? contentEncoding, string encoding) =>
        contentEncoding != null && contentEncoding.Contains(encoding, StringComparer.OrdinalIgnoreCase);
}