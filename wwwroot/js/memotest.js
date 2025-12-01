(function() {
    let primera = null;
    let segunda = null;
    let bloqueado = false;

    const cartas = document.querySelectorAll(".carta");
    const totalCartas = cartas.length;
    
    // Obtener nivel actual de la URL
    const urlParams = new URLSearchParams(window.location.search);
    const nivelActual = parseInt(urlParams.get('nivel')) || 1;

    function verificarVictoria() {
        const encontradas = document.querySelectorAll(".carta.encontrada").length;
        if (encontradas === totalCartas && totalCartas > 0) {
            setTimeout(function() {
                mostrarCartelVictoria();
            }, 500);
        }
    }

    function mostrarCartelVictoria() {
        // Si ya existe el cartel, no crear otro
        if (document.querySelector(".victoria-overlay")) return;
        
        // Crear overlay
        const overlay = document.createElement("div");
        overlay.className = "victoria-overlay";
        
        // Crear cartel
        const cartel = document.createElement("div");
        cartel.className = "victoria-cartel";
        
        if (nivelActual < 3) {
            cartel.innerHTML = 
                '<h2>Ganaste</h2>' +
                '<p>Completaste el nivel ' + nivelActual + '</p>' +
                '<a href="/Juego/Memotest?nivel=' + (nivelActual + 1) + '" class="btn-victoria">Siguiente nivel</a>' +
                '<a href="/Juego/Memotest" class="btn-victoria-secundario">Volver a niveles</a>';
        } else {
            cartel.innerHTML = 
                '<h2>Felicitaciones</h2>' +
                '<p>Completaste todos los niveles</p>' +
                '<a href="/Juego/Memotest" class="btn-victoria">Volver a jugar</a>' +
                '<a href="/Juego/Index" class="btn-victoria-secundario">Ir a juegos</a>';
        }
        
        overlay.appendChild(cartel);
        document.body.appendChild(overlay);
        
        // Animación de entrada
        setTimeout(function() {
            overlay.classList.add("visible");
        }, 10);
    }
    
    // Verificar victoria al cargar (por si ya estaban encontradas)
    verificarVictoria();
    
    cartas.forEach(function(carta) {
        carta.onclick = function(e) {
            e.preventDefault();
            e.stopPropagation();
            
            // Si está bloqueado (esperando resultado), no hacer nada
            if (bloqueado) {
                return false;
            }

            // Si ya está encontrada, no hacer nada
            if (carta.classList.contains("encontrada")) {
                return false;
            }

            // Si ya está volteada (es la misma carta), no hacer nada
            if (carta.classList.contains("volteada")) {
                return false;
            }

            let index = parseInt(carta.dataset.index);

            // Voltear la carta
            carta.classList.add("volteada");

            if (primera === null) {
                // Es la primera carta
                primera = index;
            } else {
                // Es la segunda carta
                segunda = index;
                bloqueado = true; // Bloquear hasta resolver

                fetch("/Juego/VerificarPar", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ index1: primera, index2: segunda })
                })
                .then(function(r) { return r.json(); })
                .then(function(res) {
                    const cartaPrimera = document.querySelector("[data-index='" + primera + "']");
                    const cartaSegunda = document.querySelector("[data-index='" + segunda + "']");

                    if (res.esPar) {
                        // Si coinciden, marcar como encontradas
                        cartaPrimera.classList.add("encontrada");
                        cartaSegunda.classList.add("encontrada");
                        // Desbloquear inmediatamente
                        primera = null;
                        segunda = null;
                        bloqueado = false;
                        // Verificar si ganó
                        verificarVictoria();
                    } else {
                        // Si no coinciden, esperar 1.5s y voltear
                        setTimeout(function() {
                            cartaPrimera.classList.remove("volteada");
                            cartaSegunda.classList.remove("volteada");
                            primera = null;
                            segunda = null;
                            bloqueado = false;
                        }, 1500);
                    }
                })
                .catch(function(err) {
                    // Si hay error, desbloquear
                    primera = null;
                    segunda = null;
                    bloqueado = false;
                });
            }
            return false;
        };
    });
})();

