using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Culturi.Controllers
{
    public class JuegoController : Controller
    {
        public IActionResult Index()
        {
            // Por ahora devolvemos una lista vacía ya que la vista tiene sus propias opciones
            var juegos = new List<Juego>();
            return View(juegos);
        }

        public IActionResult Memotest(int? nivel)
        {
            // Si no hay nivel seleccionado, mostrar pantalla de selección
            if (nivel == null || nivel < 1 || nivel > 3)
            {
                ViewBag.MostrarSeleccion = true;
                return View();
            }

            ViewBag.Nivel = nivel.Value;
            ViewBag.MostrarSeleccion = false;

            // Generar lista de cartas según el nivel (n1, n2, n3)
            var cartas = new List<string>();
            string prefijo = $"n{nivel}_p";
            
            // Por ahora solo tenemos nivel 1, pero la estructura será igual para n2 y n3
            for (int i = 1; i <= 8; i++)
            {
                cartas.Add($"{prefijo}{i}a.png");
                cartas.Add($"{prefijo}{i}b.png");
            }

            // Mezclamos solo la primera vez o si cambió el nivel
            string nivelSesion = HttpContext.Session.GetString("NivelMemotest");
            if (nivelSesion != nivel.Value.ToString() || HttpContext.Session.GetString("CartasMezcladas") == null)
            {
                var random = new Random();
                var cartasMezcladas = cartas.OrderBy(x => random.Next()).ToList();
                HttpContext.Session.SetString("CartasMezcladas", string.Join(",", cartasMezcladas));
                HttpContext.Session.SetString("Volteadas", "");
                HttpContext.Session.SetString("Encontradas", "");
                HttpContext.Session.SetString("NivelMemotest", nivel.Value.ToString());
            }

            return View();
        }

        private bool SonPareja(string carta1, string carta2)
        {
            // Comparar basándose en el prefijo del par
            // Ejemplo: n1_p1a.png y n1_p1b.png son un par
            if (carta1.Length < 6 || carta2.Length < 6) return false;
            
            var base1 = carta1.Substring(0, carta1.Length - 6); // quitar "a.png" o "b.png"
            var base2 = carta2.Substring(0, carta2.Length - 6);
            
            return base1 == base2 && carta1 != carta2;
        }

        [HttpPost]
        public IActionResult ReiniciarMemotest()
        {
            int? nivel = int.TryParse(HttpContext.Session.GetString("NivelMemotest"), out int n) ? n : (int?)null;
            HttpContext.Session.Remove("CartasMezcladas");
            HttpContext.Session.Remove("Volteadas");
            HttpContext.Session.Remove("Encontradas");
            
            if (nivel.HasValue) {
                return RedirectToAction("Memotest", new { nivel = nivel.Value });
            }
            return RedirectToAction("Memotest");
        }

        [HttpPost]
        public JsonResult VerificarPar([FromBody] ParRequest req)
        {
            string[] cartas = HttpContext.Session.GetString("CartasMezcladas").Split(',');
            bool esPar = SonPareja(cartas[req.index1], cartas[req.index2]);
            if (esPar) 
            {
                var encontradas = HttpContext.Session.GetString("Encontradas")
                .Split(',', StringSplitOptions.RemoveEmptyEntries)
                .Select(int.Parse)
                .ToList();

                encontradas.Add(req.index1);
                encontradas.Add(req.index2);

                HttpContext.Session.SetString("Encontradas", string.Join(",", encontradas));
            }
            return Json(new { esPar });
        }

        public class ParRequest
        {
            public int index1 { get; set; }
            public int index2 { get; set; }
        }


    }
}