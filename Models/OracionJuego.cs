namespace PrimerProyecto.Models
{
    public class OracionJuego
    {
        public int id_oracion { get; set; }
        public int id_pais { get; set; }
        public int nivel { get; set; }
        public string texto { get; set; } = "";
        public int orden { get; set; }
    }

}
