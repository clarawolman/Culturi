using Microsoft.AspNetCore.Mvc;
using PrimerProyecto.Models;
using Newtonsoft.Json;

namespace Culturi.Controllers
{
    public class TramiteController : Controller
    {
        public IActionResult Index()
        {
            // Obtener usuario logueado (lo mismo que usás en el resto de la app)
            Usuario u = BD.ObtenerUsuarioPorSession(HttpContext);
            Console.WriteLine(u.Nombre);
            if (u == null)
                return RedirectToAction("Login", "Usuario");

            // Trámites sugeridos según país origen/destino
            List<Tramite> sugeridos = BD.ObtenerTramites().
                Where(t =>
                    t.id_paisDestino == u.id_paisDestino &&
                    (t.id_paisOrigen == u.id_paisOrigen || t.id_paisOrigen == null)
                ).ToList();

            // Trámites que el usuario ya agregó (desde ProgresoTramites)
            List<Tramite> misTramites = BD.ObtenerMisTramites(u.IdUsuario);

            // Crear viewmodel
            TramitesVM vm = new TramitesVM
            {
                TramitesParaVos = sugeridos,
                MisTramites = misTramites
            };

            return View(vm);
        }

        public IActionResult Detalle(int id)
        {
            Tramite tramite = BD.ObtenerTramitePorId(id);
            if (tramite == null) return NotFound();

            tramite.Pasos = BD.ObtenerPasosDelTramite(id);
            return View(tramite);
        }

        

    [HttpPost]
public IActionResult AgregarTramite(int IdTramite)
{
    Console.WriteLine("============================");
    Console.WriteLine("ID QUE LLEGA AL POST: " + IdTramite);
    Console.WriteLine("============================");

    Usuario u = BD.ObtenerUsuarioPorSession(HttpContext);
    BD.AgregarTramiteAUsuario(u.IdUsuario, IdTramite);

    return RedirectToAction("Index");
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

        [HttpPost]
        public IActionResult ObtenerPasosDelTramite(int idTramite)
        {
            ViewBag.Pasos = BD.ObtenerPasosDelTramite(idTramite);
            return View("Detalle");
        }
    }
}
