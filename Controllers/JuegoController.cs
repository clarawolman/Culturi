using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Culturi.Controllers
{
    public class JuegoController : Controller
    {
        public IActionResult Memotest()
        {
            // Lista de imágenes (pares)
            var cartas = new List<string>
            {
                "mate.jpg", "mateTexto.jpg",
                "tango.jpg", "tangoTexto.jpg",
                "pibe.jpg", "pibeTexto.jpg",
                "joda.jpg", "jodaTexto.jpg"
            };

            // Mezclamos solo la primera vez
            if (HttpContext.Session.GetString("CartasMezcladas") == null)
            {
                var random = new Random();
                var cartasMezcladas = cartas.OrderBy(x => random.Next()).ToList();
                HttpContext.Session.SetString("CartasMezcladas", string.Join(',', cartasMezcladas));
                HttpContext.Session.SetString("Volteadas", "");
                HttpContext.Session.SetString("Encontradas", "");
            }

            return View();
        }

        [HttpPost]
        public IActionResult TocarCarta(int index)
        {
            var cartas = HttpContext.Session.GetString("CartasMezcladas")?.Split(',') ?? new string[0];
            var volteadas = HttpContext.Session.GetString("Volteadas")?.Split(',', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToList() ?? new List<int>();
            var encontradas = HttpContext.Session.GetString("Encontradas")?.Split(',', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToList() ?? new List<int>();

            if (!volteadas.Contains(index))
                volteadas.Add(index);

            if (volteadas.Count == 2)
            {
                var primera = cartas[volteadas[0]].Substring(0, cartas[volteadas[0]].Length - 5);
                var segunda = cartas[volteadas[1]].Substring(0, cartas[volteadas[1]].Length - 5);

                if (primera == segunda)
                {
                    encontradas.AddRange(volteadas);
                }
                volteadas.Clear();
            }

            HttpContext.Session.SetString("Volteadas", string.Join(',', volteadas));
            HttpContext.Session.SetString("Encontradas", string.Join(',', encontradas));

            return RedirectToAction("Memotest");
        }

        [HttpPost]
        public IActionResult ReiniciarMemotest()
        {
            HttpContext.Session.Remove("CartasMezcladas");
            HttpContext.Session.Remove("Volteadas");
            HttpContext.Session.Remove("Encontradas");
            return RedirectToAction("Memotest");
        }
    }
}