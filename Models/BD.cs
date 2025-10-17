using Microsoft.Data.SqlClient;
using Dapper;
namespace Culturi;
class BD
{

    private static string _connectionString = @"Server=localhost;DataBase=BD_TP08_PreguntadORT_Stock_Kampel_Pita;Integrated Security=True;TrustServerCertificate=True;";
    public static Usuario LevantarUsuario(string nombre)
    {
        Usuario miUsuario = null;
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"SELECT 
                    nombre, 
                    contrasena 
                FROM Usuario 
                WHERE nombre = @pnombreUsuario";


            miUsuario = connection.QueryFirstOrDefault<Usuario>(
         query, new { pnombreUsuario = nombre });

        }
        return miUsuario;
    }

    public static void AgregarUsuario(string NombreUsuarioIngresado, string Contrasena)
    {
        string query = "INSERT INTO Usuario (nombre, contrasena) VALUES (@pNombreUsuarioIngresado, @pContrasena)";
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            connection.Execute(query, new { pNombreUsuarioIngresado = NombreUsuarioIngresado, pContrasena = Contrasena });
        }
    }
}