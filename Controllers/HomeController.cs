using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using PrimerProyecto.Models;

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
        return View();
    }

}


