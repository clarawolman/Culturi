using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using PrimerProyecto.Models;
using Dapper;
using Microsoft.Data.SqlClient;
using Culturi.Models;
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
            // obtener usuario
            var usuario = BD.ObtenerUsuarioPorSession(HttpContext);
            if (usuario == null) 
                return RedirectToAction("Login", "Usuario");
            
            // Mostrar pantalla de selección si no eligen nivel
            if (!nivel.HasValue || nivel < 1 || nivel > 2)
            {
                ViewBag.MostrarSeleccion = true;
                return View();
            }

            ViewBag.MostrarSeleccion = false;
            ViewBag.Nivel = nivel.Value;

            // Generar cartas
            var cartas = new List<string>();
            string prefijo = $"n{nivel}_p";

            for (int i = 1; i <= 8; i++)
            {
                cartas.Add($"{prefijo}{i}a.png");
                cartas.Add($"{prefijo}{i}b.png");
            }

            // Mezcla
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
            // ejemplo: n1_p5a.png
            string base1 = carta1.Split('.')[0]; // n1_p5a
            string base2 = carta2.Split('.')[0]; // n1_p5b

            // eliminar última letra (a o b)
            base1 = base1.Substring(0, base1.Length - 1);
            base2 = base2.Substring(0, base2.Length - 1);

            return base1 == base2;
        }


        [HttpPost]
        public IActionResult ReiniciarMemotest()
        {
            int? nivel = int.TryParse(HttpContext.Session.GetString("NivelMemotest"), out int n) ? n : (int?)null;
            HttpContext.Session.Remove("CartasMezcladas");
            HttpContext.Session.Remove("Volteadas");
            HttpContext.Session.Remove("Encontradas");

            if (nivel.HasValue)
            {
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

        public IActionResult Oraciones(int? nivel)
        {
            // obtener usuario logueado
            var usuario = BD.ObtenerUsuarioPorSession(HttpContext);
            if (usuario == null)
                return RedirectToAction("Login", "Usuario");

            int idPais = usuario.id_paisDestino;

            // pantalla de selección
            if (!nivel.HasValue || nivel < 1 || nivel > 3)
            {
                ViewBag.MostrarSeleccion = true;
                return View("Oraciones");  // ← importante
            }

            ViewBag.MostrarSeleccion = false;
            ViewBag.Nivel = nivel.Value;

            using (var db = BD.GetConnection())
            {
                var oraciones = db.Query<OracionJuego>(
                    @"SELECT *
                      FROM OracionJuego
                      WHERE nivel = @niv AND id_pais = @pais
                      ORDER BY orden",
                    new { niv = nivel.Value, pais = idPais }
                ).ToList();

                var opciones = db.Query<OracionOpcion>(
                    @"SELECT o.*
                      FROM OracionOpcion o
                      INNER JOIN OracionJuego j ON j.id_oracion = o.id_oracion
                      WHERE j.nivel = @niv AND j.id_pais = @pais",
                    new { niv = nivel.Value, pais = idPais }
                ).ToList();

                ViewBag.Oraciones = oraciones;
                ViewBag.Opciones = opciones;
            }

            return View("Oraciones");
        }
    }
}