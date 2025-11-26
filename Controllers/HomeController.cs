using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using PrimerProyecto.Models;
using Newtonsoft.Json;


namespace Culturi.Controllers;

public class HomeController : Controller
{
    public IActionResult Index()
    {
        return View();
    }

    public IActionResult QuienesSomos()
    {
        return View();
    }
    public IActionResult Menu()
    {
        return View();
    }

    public IActionResult Home()
    {
        // Recupera usuario desde sesión
        string usuarioJson = HttpContext.Session.GetString("usuarioLogueado");

        if (usuarioJson == null)
            return RedirectToAction("Login", "Usuario");

        Usuario usuario = JsonConvert.DeserializeObject<Usuario>(usuarioJson);

        // Conseguir los trámites del usuario
        List<Tramite> misTramites = BD.ObtenerMisTramites(usuario.IdUsuario);

        // Calcular progreso para cada trámite
        foreach (var t in misTramites)
        {
            var pasos = BD.ObtenerPasosDelTramite(t.IdTramite);

            int total = pasos.Count;
            int completos = pasos.Count(p => p.completado == true);

            t.ProgresoPorcentaje = total == 0 ? 0 : (int)((double)completos / total * 100);
        }

        // Devolver a la vista EXACTAMENTE lo que espera
        return View(misTramites);
    }


}


