namespace Proxy.Web.Abstraction;

public interface IDecompressService
{
	/// <summary>
	/// Asynchronously decompresses the provided data based on the specified content encoding.
	/// </summary>
	/// <param name="contentEncoding">The collection of content encodings. If null or empty, the data is read as is.</param>
	/// <param name="data">The data to be decompressed.</param>
	/// <returns>A task that represents the asynchronous operation. The task result contains the decompressed data as a string.</returns>
	/// <remarks>
	/// This method supports the "gzip", "deflate", and "br" content encodings. If the content encoding is not recognized or not provided, the data is read as is.
	/// </remarks>
	Task<string> DecompressData(ICollection<string>? contentEncoding, byte[] data);
}
