using System.Text.RegularExpressions;
using AngleSharp.Dom;
using AngleSharp.Html.Parser;

namespace Proxy.Web;

public static partial class StringExtensions
{
	public static async Task<string> ReplaceWord(this string html)
	{
		var parser = new HtmlParser();
		var document = await parser.ParseDocumentAsync(html);
		var textNodes = document.Body?.Descendents().OfType<IText>();

		// return as is
		if (textNodes == null)
			return html;

		// as fast as possible :D
		Parallel.ForEach(textNodes, textNode =>
		{
			var newText = WordsThatAreSixLettersLongRegex().Replace(textNode.TextContent, "$&\u2122\ufe0f");
			textNode.TextContent = newText;
		});

		return document.DocumentElement.OuterHtml;
	}

	[GeneratedRegex(@"\b\w{6}\b")]
	private static partial Regex WordsThatAreSixLettersLongRegex();
}
