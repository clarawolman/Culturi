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
                HttpContext.Session.SetInt32("IdUsuario", usuario.IdUsuario);

                return RedirectToAction("Home", "Home");
            }
            else
            {
                ViewBag.Mensaje = "Usuario o contraseña incorrectos";
                return View();
            }
        }
         public IActionResult Noti()
{
    string usuarioJson = HttpContext.Session.GetString("usuarioLogueado");
    if (usuarioJson == null)
        return RedirectToAction("Login");

    Usuario usuarioSesion = JsonConvert.DeserializeObject<Usuario>(usuarioJson);
    Usuario usuario = BD.ObtenerUsuarioPorId(usuarioSesion.IdUsuario);

    // 🔥 Asegurar foto por defecto si no tiene
    if (string.IsNullOrEmpty(usuario.FotoPerfil))
        usuario.FotoPerfil = "PERFILdefault.png";

    return View(usuario);
}




        public IActionResult Registro()
        {
            return View();
        }
    



        [HttpPost]
public IActionResult Registro(
    string nombre,
    string nombreUsuarioIngresado,
    string email,
    string contrasena,
    string idioma,
    int id_paisOrigen,
    int id_paisDestino,
    DateTime fechaMigracion,
    DateTime fechaNacimiento)
{
    // Validar que el email no exista
    if (BD.ExisteEmail(email))
    {
        ViewBag.Mensaje = "El email ya está registrado, por favor iniciá sesión.";
        return View();
    }

    // Validar que el nombre de usuario no exista
    Usuario usuarioExistente = BD.LevantarUsuario(nombreUsuarioIngresado);
    if (usuarioExistente != null)
    {
        ViewBag.Mensaje = "El nombre de usuario ya está en uso, por favor elegí otro.";
        return View();
    }

    Usuario nuevoUsuario = new Usuario
{
    Nombre = nombre,
    usuario = nombreUsuarioIngresado,
    Email = email,
    Contrasena = contrasena,
    idiomaPreferencia = idioma,
    id_paisOrigen = id_paisOrigen,
    id_paisDestino = id_paisDestino,
    fechaMigracion = fechaMigracion,
    fechaNacimiento = fechaNacimiento,
    FotoPerfil = "PERFILdefault.png"   // 🔥 FOTO POR DEFECTO
};


    BD.AgregarUsuario(nuevoUsuario);

    // Recuperar el usuario recién creado desde la BD (con su ID generado)
    Usuario usuarioCreado = BD.LevantarUsuario(nombreUsuarioIngresado);

    // Guardar la sesión del usuario (igual que en Login)
    string usuarioJson = JsonConvert.SerializeObject(usuarioCreado);
    HttpContext.Session.SetString("usuarioLogueado", usuarioJson);
    HttpContext.Session.SetInt32("IdUsuario", usuarioCreado.IdUsuario);

    // Redirigir al Home (no solo mostrar la vista)
    return RedirectToAction("Home", "Home");
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

    Usuario usuarioSesion = JsonConvert.DeserializeObject<Usuario>(usuarioJson);

    // 🔥 Recuperar el usuario REAL desde la BD
    Usuario usuario = BD.ObtenerUsuarioPorId(usuarioSesion.IdUsuario);

    // 🔥 Asegurar foto de perfil por defecto
    if (string.IsNullOrEmpty(usuario.FotoPerfil))
        usuario.FotoPerfil = "PERFILdefault.png";

    ViewBag.PaisOrigen = BD.ObtenerNombrePais(usuario.id_paisOrigen);
    ViewBag.PaisDestino = BD.ObtenerNombrePais(usuario.id_paisDestino);

    return View(usuario);
}

[HttpPost("Usuario/EditarPerfil")]
public IActionResult EditarPerfilPost([Bind("IdUsuario,Nombre,usuario,Email")] Usuario model, IFormFile FotoPerfil)
{
    // 1️⃣ Levantar el usuario original desde la BD
    Usuario original = BD.ObtenerUsuarioPorId(model.IdUsuario);

    if (original == null)
        return NotFound();

    // 2️⃣ Actualizar campos
    original.Nombre = model.Nombre;
    original.usuario = model.usuario;
    original.Email = model.Email;

    // 3️⃣ Guardar la foto si se sube
    if (FotoPerfil != null && FotoPerfil.Length > 0)
    {
        string fileName = Guid.NewGuid().ToString() + Path.GetExtension(FotoPerfil.FileName);
        string path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/img/perfiles", fileName);

        if (!Directory.Exists(Path.GetDirectoryName(path)))
            Directory.CreateDirectory(Path.GetDirectoryName(path));

        using (var stream = new FileStream(path, FileMode.Create))
        {
            FotoPerfil.CopyTo(stream);
        }

        original.FotoPerfil = fileName;
    }

    // 🔥 Si NO tenía foto (y no subió una nueva), asignar default
    if (string.IsNullOrEmpty(original.FotoPerfil))
        original.FotoPerfil = "PERFILdefault.png";

    // 4️⃣ Guardar cambios finales
    BD.ActualizarUsuario(original);

    return RedirectToAction("Perfil");
}

[HttpGet]
public IActionResult EditarPerfil(int id)
{
    Usuario u = BD.ObtenerUsuarioPorId(id);

    if (u == null)
        return NotFound();

    return View(u);
}



        public IActionResult CerrarSesion()
        {
            HttpContext.Session.Clear();
            return View("~/Views/Home/Index.cshtml");
        }
    }
}
