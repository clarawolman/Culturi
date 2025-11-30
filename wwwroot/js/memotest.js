// Please see documentation at https://learn.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.
let primera = null;
let segunda = null;
let bloqueado = false;

document.querySelectorAll(".carta").forEach(carta => {
    carta.addEventListener("click", () => {
        if (bloqueado) return;

        let index = parseInt(carta.dataset.index);

        // no tocar si ya está encontrada
        if (carta.classList.contains("encontrada")) return;

        carta.classList.add("volteada");

        if (primera === null) {
            primera = index;
        } else {
            segunda = index;
            bloqueado = true;

            fetch("/Juego/VerificarPar", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ index1: primera, index2: segunda })
            })
            .then(r => r.json())
            .then(res => {

                if (res.esPar) {
                    document.querySelector(`[data-index='${primera}']`).classList.add("encontrada");
                    document.querySelector(`[data-index='${segunda}']`).classList.add("encontrada");
                } else {
                    setTimeout(() => {
                        document.querySelector(`[data-index='${primera}']`).classList.remove("volteada");
                        document.querySelector(`[data-index='${segunda}']`).classList.remove("volteada");
                    }, 1500);
                }

                primera = null;
                segunda = null;
                bloqueado = false;
            });
        }
    });
});

