// Please see documentation at https://learn.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.
function toggleMenu() {
    const menu = document.getElementById("sidebar-menu");
    const overlay = document.getElementById("menu-overlay");
    const icon = document.querySelector(".menu-icon");

    const isOpen = menu.classList.contains("menu-open");

    if (isOpen) {
        menu.classList.remove("menu-open"); 
        overlay.classList.remove("active");
        icon.classList.remove("hidden");
    } else {
        menu.classList.add("menu-open");
        overlay.classList.add("active");
        icon.classList.add("hidden");
    }
}

