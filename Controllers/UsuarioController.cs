using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using PrimerProyecto.Models;

namespace Culturi.Controllers
{
    public class UsuarioController : Controller
    {
        // Página de inicio de sesión
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Login(string nombre, string contrasena)
        {
            Usuario UsuarioPerfil = BD.LevantarUsuario(nombre);

            if (UsuarioPerfil != null && UsuarioPerfil.InicioSesion(contrasena))
            {
                HttpContext.Session.SetString("user", Objeto.ObjectToString<Usuario>(UsuarioPerfil));
                ViewBag.Usuario = UsuarioPerfil;
                return RedirectToAction("Index", "Home");
            }
            else
            {
                ViewBag.Mensaje = "Usuario o contraseña incorrectos";
                return View("Login");
            }
        }

        // Página de registro
        public IActionResult Registro()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Registro(Usuario nuevoUsuario)
        {
            ViewBag.Mensaje = "";
            if (BD.LevantarUsuario(NombreUsuario) == null)
            {
                BD.AgregarUsuario(NombreUsuarioIngresado, contrasena);
                ViewBag.Mensaje = "Usuario creado correctamente";
                return View("Index", "Home");
            }
            else
            {
                ViewBag.Mensaje = "El nombre de usuario ya está en uso";
                return RedirectToAction("Registro");
            }
        }

        // Página del perfil del usuario
        public IActionResult Perfil()
        {
            return View();
        }

        public IActionResult CerrarSesion()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index", "Home");
        }
    }
}
