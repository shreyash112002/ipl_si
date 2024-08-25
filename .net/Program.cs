using IPL2.DAO;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Npgsql;

namespace IPL2
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.
            builder.Services.AddControllers();

            // Configure Swagger/OpenAPI for API documentation.
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();
            builder.Services.AddCors(options =>
            {
                options.AddPolicy("AllowAny", builder => builder.AllowAnyHeader().AllowAnyMethod().AllowAnyOrigin());
                options.AddPolicy("FrontEndClient", builder => builder.AllowAnyHeader().AllowAnyMethod().WithOrigins("http://localhost:3000/"));
            });

            // Configure PostgreSQL connection
            var connectionString = builder.Configuration.GetConnectionString("PostgreDB");
            builder.Services.AddScoped(_ => new NpgsqlConnection(connectionString)); // Use a lambda to resolve the connection

            // Register the DAO implementation
            builder.Services.AddScoped<IDAO, DaoImplementation>();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }
            app.UseCors("AllowAny");
            app.UseCors("FrontEndClient");
            app.UseAuthorization();
            app.MapControllers();
            app.Run();
        }
    }
}
