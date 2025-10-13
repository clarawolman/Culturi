using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using PrimerProyecto.Models;

namespace Culturi.Controllers
{
    public class JuegoController : Controller
    {
        // Muestra lista de juegos (Idioma, Cultura)
        public IActionResult Index()
        {
            return View();
        }

        // Muestra niveles o preguntas del juego elegido
        public IActionResult Jugar(int id)
        {
            // Buscar juego por ID y mostrar contenido
            return View();
        }

        // Muestra una pregunta del nivel actual
        public IActionResult Pregunta(int idNivel)
        {
            return View();
        }

        // Muestra resultado final del juego
        public IActionResult Resultado(int puntaje)
        {
            ViewBag.Puntaje = puntaje;
            return View();
        }
    }
}