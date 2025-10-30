using Microsoft.Data.SqlClient;
using Dapper;
namespace Culturi;
public static class BD
{

    private static string _connectionString = @"Server=localhost;DataBase=Culturi;Integrated Security=True;TrustServerCertificate=True;";
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

    public static void AgregarUsuario(Usuario usuario)
{
    string query = @"INSERT INTO Usuario 
                        (nombre, apellido, email, contrasena, idPais, fechaRegistro)
                     VALUES 
                        (@pNombre, @pApellido, @pEmail, @pContrasena, @pIdPais, @pFechaRegistro)";
    
    using (SqlConnection connection = new SqlConnection(_connectionString))
    {
        connection.Execute(query, new
        {
            pNombre = usuario.Nombre,
            pApellido = usuario.Apellido,
            pEmail = usuario.Email,
            pContrasena = usuario.Contrasena,
            pIdPais = usuario.IdPais,
            pFechaRegistro = usuario.FechaRegistro
        });
    }
}


    public static List<Tramite> ObtenerTramites()
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"SELECT * FROM Tramite";
            List<Tramite> lista = connection.Query<Tramite>(query).ToList();
            return lista;
        }
    }
    public static Tramite ObtenerTramitePorId(int id)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"SELECT * FROM Tramite WHERE id_tramite = @pid";
            Tramite tramite = connection.QueryFirstOrDefault<Tramite>(query, new { pid = id });

            if (tramite != null)
                tramite.Pasos = ObtenerPasosDelTramite(id);

            return tramite;
        }
    }
    public static List<PasoDelTramite> ObtenerPasosDelTramite(int idTramite)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"SELECT * FROM PasoDelTramite WHERE id_tramite = @pidTramite ORDER BY numero_orden";
            List<PasoDelTramite> lista = connection.Query<PasoDelTramite>(query, new { pidTramite = idTramite }).ToList();
            return lista;
        }
    }

    public static void AgregarTramite(Tramite tramite)
    {
        string query = @"INSERT INTO Tramite (titulo, descripcion, id_paisSalida, id_paisLlegada)
                             VALUES (@pTitulo, @pDescripcion, @pSalida, @pLlegada)";
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            connection.Execute(query, new
            {
                pTitulo = tramite.Titulo,
                pDescripcion = tramite.Descripcion,
                pSalida = tramite.id_paisSalida,
                pLlegada = tramite.id_paisLlegada
            });
        }
    }
    public static bool EliminarTramite(int id)
    {
        int filas = 0;
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string queryPasos = "DELETE FROM PasoDelTramite WHERE id_tramite = @pid";
            string queryTramite = "DELETE FROM Tramite WHERE id_tramite = @pid";

            connection.Open();
            using (var tran = connection.BeginTransaction())
            {
                connection.Execute(queryPasos, new { pid = id }, tran);
                filas = connection.Execute(queryTramite, new { pid = id }, tran);
                tran.Commit();
            }
        }
        return filas > 0;
    }

    public static void MarcarPasoCompletado(int idPaso)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"UPDATE PasoDelTramite SET completado = 1 WHERE id_paso = @pidPaso";
            connection.Execute(query, new { pidPaso = idPaso });
        }
    }
    public static int ObtenerIdTramitePorPaso(int idPaso)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"SELECT id_tramite FROM PasoDelTramite WHERE id_paso = @pidPaso";
            return connection.QueryFirstOrDefault<int>(query, new { pidPaso = idPaso });
        }
    }

    public static void FinalizarTramite(int idTramite, int idUsuario)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"INSERT INTO ProgresoTramites (id_usuario, id_tramite, estado, fecha_actualizacion)
                                 VALUES (@pIdUsuario, @pIdTramite, 'Finalizado', GETDATE())";
            connection.Execute(query, new { pIdUsuario = idUsuario, pIdTramite = idTramite });
        }
    }
}
