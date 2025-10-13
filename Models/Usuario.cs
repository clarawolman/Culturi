public class Usuario
{
    public int IdUsuario { get; set; }
    public string Nombre { get; set; }
    public string Apellido { get; set; }
    public string Email { get; set; }
    public string Contraseña { get; set; }
    public int IdPais { get; set; }
    public DateTime FechaRegistro { get; set; }
    public Pais Pais { get; set; }
}