using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using PrimerProyecto.Models;
using Newtonsoft.Json;

namespace Culturi.Controllers
{
    public class UsuarioController : Controller
    {
        public IActionResult Landing()
        {
            return View();
        }
        /*public IActionResult Login()
        {
            // Si ya hay un usuario logueado, lo mando al Home
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
                // Guardamos el usuario en la sesión
                string usuarioJson = JsonConvert.SerializeObject(usuario);
                HttpContext.Session.SetString("usuarioLogueado", usuarioJson);

                // Redirigimos al Home una vez logueado
                return RedirectToAction("Index", "Home");
            }
            else
            {
                ViewBag.Mensaje = "Usuario o contraseña incorrectos";
                return View();
            }
        }*/
        public IActionResult Login(string nombre, string contrasena)
{
    if (HttpContext.Session.GetString("usuarioLogueado") != null)
        return RedirectToAction("Index", "Home");

    if (string.IsNullOrEmpty(nombre) && string.IsNullOrEmpty(contrasena))
        return View();

    // Ahora 'nombre' representa el nombre de usuario (no el nombre real)
    Usuario usuario = BD.LevantarUsuario(nombre);

    if (usuario != null && usuario.InicioSesion(contrasena))
    {
        string usuarioJson = JsonConvert.SerializeObject(usuario);
        HttpContext.Session.SetString("usuarioLogueado", usuarioJson);
        return RedirectToAction("Home", "Home");
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
        public IActionResult Registro(string nombre, string nombreUsuarioIngresado, string email, string contrasena, string idioma, string paisOrigen, string paisLlegada, DateTime fechaEmigracion, DateTime fechaNacimiento)
        {
            Usuario nuevoUsuario = new Usuario
            {
                Nombre = nombre,
                usuario = nombreUsuarioIngresado,
                Email = email,
                Contrasena = contrasena,
                idiomaPreferencia = idioma,
                id_paisOrigen = ObtenerIdPais(paisOrigen),
                id_paisDestino = ObtenerIdPais(paisLlegada),
                fechaMigracion = fechaEmigracion,
                fechaNacimiento = fechaNacimiento
            };

            BD.AgregarUsuario(nuevoUsuario);

            ViewBag.Mensaje = "Usuario creado correctamente";
            return View("~/Views/Home/Index.cshtml");
        }
        private int ObtenerIdPais(string nombrePais)
        {
            return nombrePais switch
            {
                "Argentina" => 1,
                "Chile" => 2,
                "Uruguay" => 3,
                _ => 0
            };
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
            return View("~/Views/Home/Index.cshtml");
        }
    }
}
