using Microsoft.AspNetCore.Mvc;
using PrimerProyecto.Models;
using Newtonsoft.Json;

namespace Culturi.Controllers
{
    public class TramiteController : Controller
    {
        public IActionResult Index()
        {
            // Obtener usuario logueado
            Usuario u = BD.ObtenerUsuarioPorSession(HttpContext);
            if (u == null)
                return RedirectToAction("Login", "Usuario");

            // Tramites sugeridos segun pais origen/destino
            List<Tramite> sugeridos = BD.ObtenerTramites()
                .Where(t =>
                    t.id_paisDestino == u.id_paisDestino &&
                    (t.id_paisOrigen == u.id_paisOrigen || t.id_paisOrigen == null)
                ).ToList();

            // Tramites que el usuario ya agrego
            List<Tramite> misTramites = BD.ObtenerMisTramites(u.IdUsuario);

            // Sacar de sugeridos los trámites que el usuario ya agregó
            sugeridos = sugeridos
                .Where(t => !misTramites.Any(mt => mt.IdTramite == t.IdTramite))
                .ToList();

            // Cargar los pasos de cada trámite sugerido (para el tooltip)
            foreach (var t in sugeridos)
            {
                t.Pasos = BD.ObtenerPasosDelTramite(t.IdTramite);
            }

            // Crear viewmodel (YA CON TODO CORRECTO)
            TramitesVM vm = new TramitesVM
            {
                TramitesParaVos = sugeridos,
                MisTramites = misTramites
            };

            return View(vm);
        }

        [HttpGet]
        public IActionResult PasosDelTramite(int id)
        {
            Tramite tramite = BD.ObtenerTramitePorId(id);

            if (tramite == null)
                return NotFound();

            // Levantar los pasos del trámite
            var pasos = BD.ObtenerPasosDelTramite(id);

            // Pasar título y pasos
            ViewBag.Titulo = tramite.Titulo;
            return View(pasos); // la view recibe una lista de pasos
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
            Usuario u = BD.ObtenerUsuarioPorSession(HttpContext);
            if (u == null)
                return RedirectToAction("Login", "Usuario");

            BD.EliminarTramiteDeUsuario(u.IdUsuario, id);

            return RedirectToAction("Index");
        }

        [HttpPost]
        public IActionResult FinalizarPaso(int idPaso)
        {
            BD.MarcarPasoCompletado(idPaso);
            int idTramite = BD.ObtenerIdTramitePorPaso(idPaso);
            return RedirectToAction("PasosDelTramite", new { id = idTramite });
        }

        [HttpPost]
        public IActionResult TogglePaso(int idPaso)
        {
            BD.TogglePasoCompletado(idPaso);
            int idTramite = BD.ObtenerIdTramitePorPaso(idPaso);
            return RedirectToAction("PasosDelTramite", new { id = idTramite });
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
