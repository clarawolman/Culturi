public class PasoDelTramite
{
    public int IdPaso { get; set; }
    public int IdTramite { get; set; }
    public int NumeroOrden { get; set; }
    public string Descripcion { get; set; }
    public string DocumentoRequerido { get; set; }

    public Tramite Tramite { get; set; }
}
