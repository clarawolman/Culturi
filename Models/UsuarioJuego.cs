public class UsuarioJuego
{
    public int IdUsuario { get; set; }
    public int IdJuego { get; set; }
    public int Puntaje { get; set; }
    public DateTime Fecha { get; set; }

    public Usuario Usuario { get; set; }
    public Juego Juego { get; set; }
}