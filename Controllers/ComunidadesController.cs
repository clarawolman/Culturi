using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using PrimerProyecto.Models;
using Newtonsoft.Json;


namespace Culturi.Controllers;

public class ComunidadesController : Controller
{

  public IActionResult Grupos()
        {
            
            return View();
        }

     public IActionResult Chat()
        {
            
            return View();
        }
}