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
    public string idiomaPreferencia { get; set; }
    [JsonProperty]
    public int id_paisOrigen { get; set; }
    [JsonProperty]
    public int id_paisDestino { get; set; }
    [JsonProperty]
    public DateTime fechaMigracion { get; set; }
    [JsonProperty]
    public DateTime fechaNacimiento { get; set; }
       [JsonProperty]
       public string FotoPerfil { get; set; }


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