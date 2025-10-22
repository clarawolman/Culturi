using Newtonsoft.Json;  

public class Tramite
{
     [JsonProperty]
    public int IdTramite { get; set; }
     [JsonProperty]
    public string Titulo { get; set; }
    [JsonProperty]
    public string Descripcion { get; set; }
     [JsonProperty]
    public int id_paisLlegada { get; set; }
     [JsonProperty]
    public int id_paisSalida { get; set; }
     [JsonProperty]
    public List<PasoDelTramite> Pasos { get; set; }
}