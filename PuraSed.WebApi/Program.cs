
var builder = WebApplication.CreateBuilder(args);

// Permitir que el frontend Blazor acceda a la API.
builder.Services.AddCors(options =>
{
    options.AddPolicy("PuraSedClient", policy =>
    {
        policy.WithOrigins(
                "http://localhost:5068",
                "https://localhost:7020")
              .AllowAnyHeader()
              .AllowAnyMethod();
    });
});

builder.Services.AddControllers();
builder.Services.AddOpenApi();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseHttpsRedirection();

// CORS debe ejecutarse antes de la autorización.
app.UseCors("PuraSedClient");

app.UseAuthorization();
app.MapControllers();

app.Run();
