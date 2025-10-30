using Microsoft.AspNetCore.Mvc;
using PrimerProyecto.Models;
using Newtonsoft.Json;

namespace Culturi.Controllers
{
    public class TramiteController : Controller
    {
        public IActionResult Index()
        {
            List<Tramite> listaTramites = BD.ObtenerTramites();
            return View(listaTramites);
        }

        public IActionResult Detalle(int id)
        {
            Tramite tramite = BD.ObtenerTramitePorId(id);
            if (tramite == null) return NotFound();

            tramite.Pasos = BD.ObtenerPasosDelTramite(id);
            return View(tramite);
        }

        [HttpGet]
        public IActionResult AgregarTramite()
        {
            return View();
        }

        [HttpPost]
        public IActionResult AgregarTramite(Tramite nuevo)
        {
            if (ModelState.IsValid)
            {
                BD.AgregarTramite(nuevo);
                return RedirectToAction("Index");
            }
            return View(nuevo);
        }

        [HttpPost]
        public IActionResult EliminarTramite(int id)
        {
            bool eliminado = BD.EliminarTramite(id);
            if (!eliminado)
                return NotFound();

            return RedirectToAction("Index");
        }

        [HttpPost]
        public IActionResult FinalizarPaso(int idPaso)
        {
            BD.MarcarPasoCompletado(idPaso);
            int idTramite = BD.ObtenerIdTramitePorPaso(idPaso);
            return RedirectToAction("Detalle", new { id = idTramite });
        }

       [HttpPost]
public IActionResult FinalizarTramite(int idTramite, int idUsuario)
{
    BD.FinalizarTramite(idTramite, idUsuario);
    return RedirectToAction("Index");
}
    }
}
