namespace Culturi.Models;

public class Mensaje
{
    public int IdMensaje { get; set; }
    public int IdGrupo { get; set; }
    public int IdUsuario { get; set; }
    public string Contenido { get; set; } = string.Empty;
    public DateTime FechaEnvio { get; set; } = DateTime.Now;

}