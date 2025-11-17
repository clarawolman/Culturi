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
    string usuarioJson = HttpContext.Session.GetString("usuarioLogueado");

    if (usuarioJson == null)
        return RedirectToAction("Login", "Usuario");

    Usuario usuario = JsonConvert.DeserializeObject<Usuario>(usuarioJson);

    // Si querés mostrar trámites:
    var tramites = BD.ObtenerMisTramites(usuario.IdUsuario);

    return View(tramites);
}


}


