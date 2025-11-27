using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using PrimerProyecto.Models;
using Newtonsoft.Json;


namespace Culturi.Controllers;

public class NoticiasController : Controller
{

  public IActionResult Noticias()
        {
            
            return View();
        }

     
}