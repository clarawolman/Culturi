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
        public IActionResult Login(string email, string contraseña)
        {
            // Lógica para validar usuario (buscar en BD)
            // Si es válido -> redirige a Perfil
            // Si no -> mensaje de error
            return RedirectToAction("Perfil");
        }

        // Página de registro
        public IActionResult Registro()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Registro(Usuario nuevoUsuario)
        {
            // Guardar usuario nuevo en la BD
            return RedirectToAction("Login");
        }

        // Página del perfil del usuario
        public IActionResult Perfil()
        {
            return View();
        }

        public IActionResult CerrarSesion()
        {
            // Lógica para cerrar sesión (limpiar datos)
            return RedirectToAction("Index", "Home");
        }
    }
}
