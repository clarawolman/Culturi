public class Nivel
{
    public int IdNivel { get; set; }
    public int IdJuego { get; set; }
    public int NumeroNivel { get; set; }
    public string Descripcion { get; set; }
    public string Dificultad { get; set; } // básico / intermedio / avanzado

    public Juego Juego { get; set; }
    public List<PreguntaJuego> Preguntas { get; set; }
}