public class Juego
{
    public int IdJuego { get; set; }
    public string Nombre { get; set; }
    public string Descripcion { get; set; }

    public List<Nivel> Niveles { get; set; }
}