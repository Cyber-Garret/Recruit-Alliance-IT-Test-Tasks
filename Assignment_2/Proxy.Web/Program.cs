var builder = WebApplication.CreateBuilder(args);

builder.Services
	.AddSingleton<IDecompressService, DecompressService>()
	.AddReverseProxy()
	.LoadFromConfig(builder.Configuration.GetSection("ReverseProxy"))
	.AddTransforms<WordsResponseTransform>();

var app = builder.Build();

app.UseRouting();

app.MapReverseProxy(conf => { conf.UseForwardedHeaders(); });

app.Run();
