// ************************************************* 
// Deber/Ejercicio: Práctica N° 03 - Diseño del Sistema y Arquitectura
// Asignatura: ITID803 - Diseño de Aplicaciones y Servicios para Internet
// Nombre: Angelo Conterón 
// Fecha de realización: 11/11/2026
// Fecha de entrega: 14/11/2026
// Resultados: Implementación e integración de autenticación desacoplada con ASP.NET Core Identity Core,
//             emisión y validación de tokens JWT Bearer, control de acceso basado en roles (RBAC) para 8 roles
//             oficiales de PuraSed (Sereno Moreno), arquitectura limpia con servicios e interfaces (SOLID/DRY)
//             y verificación mediante respuestas HTTP 200 OK, 201 Created, 401 Unauthorized y 403 Forbidden.
// Conclusiones: 
// * La separación entre AddIdentityCore y JwtBearer proporciona una API REST completamente stateless y desacoplada.
// * El catálogo centralizado Roles.cs erradica magic strings y simplifica el mantenimiento bajo el principio DRY.
// * La inversión de dependencias con interfaces de servicios y repositorios aísla la lógica de negocio del controlador.
// Recomendaciones: 
// * Implementar AuthenticationStateProvider en Blazor WebAssembly para sincronizar claims en el cliente reactivo.
// * Incorporar Refresh Tokens con rotación para evitar reautenticaciones constantes durante la jornada nocturna.
// Bibliografía: 
// * Microsoft Learn, "Role-based authorization in ASP.NET Core", Microsoft, 2026.
// * Martin, R. C., "Clean Architecture: A Craftsman's Guide to Software Structure and Design", Prentice Hall, 2017.
// * FIEE EPN, "Guía de Aprendizaje N° 4: ASP.NET Core Identity con JWT", ITID803, 2026.
// **************************************************

using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi;
using PuraSed.WebApi.Data;
using PuraSed.WebApi.Models;
using PuraSed.WebApi.Repositories;
using PuraSed.WebApi.Repositories.Interfaces;
using PuraSed.WebApi.Services;
using PuraSed.WebApi.Services.Interfaces;

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

// ---------- SERVICIOS ----------
builder.Services.AddControllers();

// Base de datos con Entity Framework Core (Pura Sed DbContext)
builder.Services.AddDbContext<PuraSedDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("PuraSedDb")
        ?? builder.Configuration.GetConnectionString("CafeteriaDb")));

// Configuración de ASP.NET Core Identity (Guía 4 - Paso 3)
builder.Services
    .AddIdentityCore<ApplicationUser>(options =>
    {
        options.Password.RequiredLength = 8;
        options.Password.RequireDigit = true;
        options.Password.RequireUppercase = true;
        options.Password.RequireLowercase = true;
        options.Password.RequireNonAlphanumeric = false;
        options.User.RequireUniqueEmail = true;
    })
    .AddRoles<IdentityRole>()
    .AddEntityFrameworkStores<PuraSedDbContext>();

// Repositorio Scoped para interactuar con DbContext por petición
builder.Services.AddScoped<IProductoServicio,ProductoServicio>();
builder.Services.AddScoped<IProductoRepository, ProductoRepository>();
builder.Services.AddScoped<ITokenService, TokenService>();
builder.Services.AddScoped<IAuthService, AuthService>();
builder.Services.AddScoped< IValidacionUsuarioService,ValidacionUsuarioService>();
builder.Services.AddScoped<IMesaRepository, MesaRepository>();
builder.Services.AddScoped<IMesaServicio, MesaServicio>();

// Autenticación: "los usuarios se identifican con un JWT"
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true, // valida quién emitió el token
            ValidateAudience = true, // valida para quién es
            ValidateLifetime = true, // rechaza tokens vencidos
            ValidateIssuerSigningKey = true, // valida la firma
            ValidIssuer = builder.Configuration["Jwt:Issuer"],
            ValidAudience = builder.Configuration["Jwt:Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"]!))
        };
    });

// Habilita las reglas de permisos ([Authorize], roles, políticas)
builder.Services.AddAuthorization();

// Swagger con soporte para JWT
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        Scheme = "bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Description = "Pega solo el token, sin la palabra Bearer"
    });
    c.AddSecurityRequirement(document => new OpenApiSecurityRequirement
    {
        [new OpenApiSecuritySchemeReference("Bearer", document)] = []
    });
});

// ---------- PIPELINE ----------
var app = builder.Build();

// Sembrado de roles, usuarios base y catálogo Cervecería/Picantería (Sereno Moreno / Pura Sed)
using (var scope = app.Services.CreateScope())
{
    var context = scope.ServiceProvider.GetRequiredService<PuraSedDbContext>();
    await context.Database.MigrateAsync();
    await IdentitySeeder.SeedAsync(scope.ServiceProvider, app.Configuration);
    await ProductoSeeder.SeedAsync(context);
    await MesaSeeder.SeedAsync(context);
}

app.UseHttpsRedirection();

// CORS debe ejecutarse antes de la autenticación/autorización
app.UseCors("PuraSedClient");

// Activar Swagger en el pipeline (solo en desarrollo)
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
    app.MapGet("/", () => Results.Redirect("/swagger"));
}

app.UseAuthentication(); // 1.º: ¿quién eres? (lee el token)
app.UseAuthorization();  // 2.º: ¿tienes permiso?

app.MapControllers();

app.Run();
