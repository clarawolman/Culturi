using Newtonsoft.Json;  
public class Usuario
{
    [JsonProperty]
    public int IdUsuario { get; set; }
    [JsonProperty]
    public string Nombre { get; set; }
    [JsonProperty]
    public string usuario { get; set; }
    [JsonProperty]
    public string Email { get; set; }
    [JsonProperty]
    public string Contrasena { get; set; }
    [JsonProperty]
    public int IdPais { get; set; }
    [JsonProperty]
    public DateTime FechaRegistro { get; set; }
    [JsonProperty]
    public Pais Pais { get; set; }

    public bool InicioSesion(string ContrasenaIngresada)
    {
        bool iguales = Contrasena == ContrasenaIngresada;
        return iguales;
    }

    public bool ElUsuarioExiste(string NombreUsuarioIngresado)
    {
        return Nombre == NombreUsuarioIngresado;
    }
}