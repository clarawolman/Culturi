(function () {
    let primera = null;
    let segunda = null;
    let bloqueado = false;

    const cartas = document.querySelectorAll(".carta");
    if (cartas.length === 0) return; // por si el script se carga en otra view

    const totalCartas = cartas.length;
    let parejasEncontradas = 0; // cada vez que acierta un par sumamos 1

    const urlParams = new URLSearchParams(window.location.search);
    const nivelActual = parseInt(urlParams.get("nivel") || "1", 10);

    function mostrarCartelVictoria() {
        if (document.querySelector(".victoria-overlay")) return;

        const overlay = document.createElement("div");
        overlay.className = "victoria-overlay";

        const cartel = document.createElement("div");
        cartel.className = "victoria-cartel";

        if (nivelActual === 1) {
            cartel.innerHTML = `
                <h2>¡Muy bien!</h2>
                <p>Completaste el nivel 1</p>
                <a href="/Juego/Memotest?nivel=2" class="btn-victoria">Siguiente nivel</a>
                <a href="/Juego/Memotest" class="btn-victoria-secundario">Volver a niveles</a>`;
        } else {
            cartel.innerHTML = `
                <h2>¡Felicitaciones!</h2>
                <p>Completaste todos los niveles</p>
                <a href="/Juego/Memotest" class="btn-victoria">Volver a jugar</a>
                <a href="/Juego/Index" class="btn-victoria-secundario">Ir a Juegos</a>`;
        }

        overlay.appendChild(cartel);
        document.body.appendChild(overlay);

        // animación
        setTimeout(() => overlay.classList.add("visible"), 20);
    }

    function verificarVictoria() {
        // Cada pareja are 2 cartas, por eso parejasEncontradas * 2
        if (parejasEncontradas * 2 === totalCartas && totalCartas > 0) {
            mostrarCartelVictoria();
        }
    }

    // Por si ya hay cartas marcadas como encontradas al entrar (no es tu caso, pero queda prolijo)
    parejasEncontradas = document.querySelectorAll(".carta.encontrada").length / 2;
    verificarVictoria();

    cartas.forEach(carta => {
        carta.onclick = function (e) {
            e.preventDefault();
            e.stopPropagation();

            if (bloqueado) return;
            if (carta.classList.contains("encontrada")) return;
            if (carta.classList.contains("volteada")) return;

            const index = parseInt(carta.dataset.index, 10);
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
                        const c1 = document.querySelector("[data-index='" + primera + "']");
                        const c2 = document.querySelector("[data-index='" + segunda + "']");

                        if (res.esPar) {
                            c1.classList.add("encontrada");
                            c2.classList.add("encontrada");

                            parejasEncontradas++;        // ✅ sumamos una pareja
                            primera = null;
                            segunda = null;
                            bloqueado = false;

                            verificarVictoria();          // ✅ chequeamos si ya ganó
                        } else {
                            setTimeout(() => {
                                c1.classList.remove("volteada");
                                c2.classList.remove("volteada");
                                primera = null;
                                segunda = null;
                                bloqueado = false;
                            }, 1500);
                        }
                    })
                    .catch(() => {
                        primera = null;
                        segunda = null;
                        bloqueado = false;
                    });
            }
        };
    });
})();
