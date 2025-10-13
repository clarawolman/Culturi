using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using PrimerProyecto.Models;

namespace Culturi.Controllers;
    public class ChatbotController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public IActionResult EnviarPregunta(string mensajeUsuario)
        {
            // Acá se conectaría con la API de Gemini o n8n
            // y devolvería la respuesta del bot.
            ViewBag.RespuestaBot = "Respuesta simulada del chatbot.";
            ViewBag.MensajeUsuario = mensajeUsuario;
            return View("Index");
        }
    }


