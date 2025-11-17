using Microsoft.Data.SqlClient;
using Dapper;
namespace Culturi;
public static class BD
{

    private static string _connectionString = @"Server=localhost;DataBase=Culturi;Integrated Security=True;TrustServerCertificate=True;";
    public static Usuario LevantarUsuario(string nombreUsuario)
    {
        Usuario miUsuario = null;
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"SELECT 
                            id_usuario AS IdUsuario,   -- 👈 usa el nombre real de tu columna
                            nombre,
                            usuario,
                            email,
                            contrasena,
                            idiomaPreferencia,
                            id_paisOrigen,
                            id_paisDestino,
                            fechaMigracion,
                            fechaNacimiento
                         FROM Usuario 
                         WHERE usuario = @pnombreUsuario";

            miUsuario = connection.QueryFirstOrDefault<Usuario>(
                query, new { pnombreUsuario = nombreUsuario });
        }
        return miUsuario;
    }



    public static void AgregarUsuario(Usuario usuario)
{
    string query = @"INSERT INTO Usuario 
                    (nombre, usuario, email, contrasena, idiomaPreferencia, 
                     id_paisOrigen, id_paisDestino, fechaMigracion, fechaNacimiento)
                 VALUES 
                    (@Nombre, @Usuario, @Email, @Contrasena, @IdiomaPreferencia,
                     @IdPaisOrigen, @IdPaisDestino, @FechaMigracion, @FechaNacimiento)";

    using (SqlConnection connection = new SqlConnection(_connectionString))
    {
        connection.Execute(query, new
        {
            Nombre = usuario.Nombre,
            Usuario = usuario.usuario,
            Email = usuario.Email,
            Contrasena = usuario.Contrasena,
            IdiomaPreferencia = usuario.idiomaPreferencia,
            IdPaisOrigen = usuario.id_paisOrigen,
            IdPaisDestino = usuario.id_paisDestino,
            FechaMigracion = usuario.fechaMigracion,
            FechaNacimiento = usuario.fechaNacimiento
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
        string query = @"INSERT INTO Tramite (titulo, descripcion, id_paisOrigen, id_paisDestino)
                     VALUES (@pTitulo, @pDescripcion, @pOrigen, @pDestino)";

        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            connection.Execute(query, new
            {
                pTitulo = tramite.Titulo,
                pDescripcion = tramite.Descripcion,
                pOrigen = tramite.id_paisOrigen,       // propiedad correcta en tu model
                pDestino = tramite.id_paisDestino
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
    public static bool ExisteEmail(string email)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = "SELECT COUNT(*) FROM Usuario WHERE email = @pEmail";
            int count = connection.ExecuteScalar<int>(query, new { pEmail = email });
            return count > 0;
        }
    }
    public static string ObtenerNombrePais(int idPais)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = "SELECT nombre FROM Pais WHERE id_pais = @pid";
            return connection.QueryFirstOrDefault<string>(query, new { pid = idPais });
        }
    }
    public static Usuario ObtenerUsuarioPorSession(HttpContext context)
    {
        int? id = context.Session.GetInt32("IdUsuario");

        if (id == null)
            return null;

        return ObtenerUsuarioPorId(id.Value);
    }

public static Usuario ObtenerUsuarioPorId(int idUsuario)
{
    using (SqlConnection connection = new SqlConnection(_connectionString))
    {
        string query = @"SELECT 
                            id_usuario AS IdUsuario,
                            nombre,
                            usuario,
                            email,
                            contrasena,
                            idiomaPreferencia,
                            id_paisOrigen,
                            id_paisDestino,
                            fechaMigracion,
                            fechaNacimiento
                         FROM Usuario 
                         WHERE id_usuario = @pid";

        return connection.QueryFirstOrDefault<Usuario>(query, new { pid = idUsuario });
    }
}

    public static List<Tramite> ObtenerMisTramites(int idUsuario)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"
            SELECT t.*
            FROM ProgresoTramites p
            INNER JOIN Tramite t ON t.id_tramite = p.id_tramite
            WHERE p.id_usuario = @pid";

            return connection.Query<Tramite>(query, new { pid = idUsuario }).ToList();
        }
    }
    public static void AgregarTramiteAUsuario(int idUsuario, int idTramite)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"INSERT INTO ProgresoTramites (id_usuario, id_tramite, estado, fecha_actualizacion)
                         VALUES (@u, @t, 'pendiente', GETDATE())";

            connection.Execute(query, new { u = idUsuario, t = idTramite });
        }
    }
    public static List<Tramite> ObtenerTramitesParaUsuario(Usuario u)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            string query = @"
            SELECT * 
            FROM Tramite
            WHERE id_paisDestino = @destino
              AND (id_paisOrigen = @origen OR id_paisOrigen IS NULL)";

            return connection.Query<Tramite>(query, new
            {
                destino = u.id_paisDestino,
                origen = u.id_paisOrigen
            }).ToList();
        }
    }

}
