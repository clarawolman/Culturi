namespace PrimerProyecto.Models
{
    public class OracionOpcion
    {
        public int id_opcion { get; set; }
        public int id_oracion { get; set; }
        public string texto { get; set; } = "";
        public bool es_correcta { get; set; }
    }
}