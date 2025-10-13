using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using PrimerProyecto.Models;

namespace Culturi.Controllers
{
    public class TramiteController : Controller
    {
        // Muestra todos los trámites
        public IActionResult Index()
        {
            // Aquí traerías una lista de trámites desde la BD
            return View();
        }

        // Muestra el detalle de un trámite y sus pasos
        public IActionResult Detalle(int id)
        {
            // Buscar trámite por id y mostrar pasos
            return View();
        }

        // (Opcional) Lista de trámites del usuario o favoritos
        public IActionResult MisTramites()
        {
            return View();
        }
    }
}