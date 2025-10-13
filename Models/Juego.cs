public class Juego
{
    public int IdJuego { get; set; }
    public string Nombre { get; set; }
    public string Tipo { get; set; } // cultura / idioma
    public string Descripcion { get; set; }

    public List<Nivel> Niveles { get; set; }
}