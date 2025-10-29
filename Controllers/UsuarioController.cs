using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using PrimerProyecto.Models;
using Newtonsoft.Json;

namespace Culturi.Controllers
{
    public class UsuarioController : Controller
    {
       
        public IActionResult Login()
        {
            if (HttpContext.Session.GetString("usuarioLogueado") != null)
                return RedirectToAction("Index", "Home");

            return View();
        }

        [HttpPost]
        public IActionResult Login(string nombre, string contrasena)
        {
            Usuario usuario = BD.LevantarUsuario(nombre);

            if (usuario != null && usuario.InicioSesion(contrasena))
            {
                string usuarioJson = JsonConvert.SerializeObject(usuario);
                HttpContext.Session.SetString("usuarioLogueado", usuarioJson);

                ViewBag.Usuario = usuario;
                return RedirectToAction("Index", "Home");
            }
            else
            {
                ViewBag.Mensaje = "Usuario o contraseña incorrectos";
                return View();
            }
        }

        public IActionResult Registro()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Registro(string nombre, string apellido, string email, string contrasena, int idPais)
        {
            Usuario existente = BD.LevantarUsuario(nombre);
            if (existente != null)
            {
                ViewBag.Mensaje = "El nombre de usuario ya está en uso";
                return View();
            }

            Usuario nuevoUsuario = new Usuario
            {
                Nombre = nombre,
                Apellido = apellido,
                Email = email,
                Contrasena = contrasena,
                IdPais = idPais,
                FechaRegistro = DateTime.Now
            };

            BD.AgregarUsuario(nuevoUsuario, contrasena);

            string usuarioJson = JsonConvert.SerializeObject(nuevoUsuario);
            HttpContext.Session.SetString("usuarioLogueado", usuarioJson);

            ViewBag.Mensaje = "Usuario creado correctamente";
            return RedirectToAction("Index", "Home");
        }

        public IActionResult Perfil()
        {
            string usuarioJson = HttpContext.Session.GetString("usuarioLogueado");
            if (usuarioJson == null)
                return RedirectToAction("Login");

            Usuario usuario = JsonConvert.DeserializeObject<Usuario>(usuarioJson);
            return View(usuario);
        }

        public IActionResult CerrarSesion()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index", "Home");
        }
    }
}
