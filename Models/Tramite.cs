public class Tramite
{
    public int IdTramite { get; set; }
    public string Titulo { get; set; }
    public string Descripcion { get; set; }
    public int IdPais { get; set; }
    public string Tipo { get; set; }

    public Pais Pais { get; set; }
    public List<PasoDelTramite> Pasos { get; set; }
}