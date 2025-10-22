using Newtonsoft.Json;

public class PasoDelTramite
{
     [JsonProperty]
    public int IdPaso { get; set; }
     [JsonProperty]
    public int IdTramite { get; set; }
     [JsonProperty]
    public int NumeroOrden { get; set; }
     [JsonProperty]
    public string Descripcion { get; set; }
     [JsonProperty]
    public string DocumentoRequerido { get; set; }
    [JsonProperty]
    public bool Completado { get; set; }
}
