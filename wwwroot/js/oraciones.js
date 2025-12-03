document.addEventListener("DOMContentLoaded", function () {
    const opciones  = document.querySelectorAll(".opcion");
    const dropzones = document.querySelectorAll(".dropzone");

    console.log("Dropzones:", dropzones.length); // debug: debería ser > 0 en el nivel

    // nada que hacer si estás en la pantalla de niveles
    if (dropzones.length === 0 || opciones.length === 0) return;

    // arrastrar
    opciones.forEach(op => {
        op.addEventListener("dragstart", e => {
            e.dataTransfer.setData("text/plain", e.target.dataset.op);
        });
    });

    // soltar
    dropzones.forEach(z => {
        z.addEventListener("dragover", e => e.preventDefault());

        z.addEventListener("drop", e => {
            e.preventDefault();

            const idOpcion = e.dataTransfer.getData("text/plain");
            const opcion = document.querySelector(`[data-op='${idOpcion}']`);
            if (!opcion) return;

            const id_oracion = opcion.dataset.oracion;
            const correcta   = opcion.dataset.correcta === "true";

            const oracionDiv  = z.closest(".oracion");
            const idOracionDiv = oracionDiv.dataset.id;

            // opción de otra oración
            if (id_oracion !== idOracionDiv) {
                z.classList.add("incorrecto");
                setTimeout(() => z.classList.remove("incorrecto"), 600);
                return;
            }

            if (correcta) {
                z.textContent = opcion.textContent;
                z.classList.add("correcto");
                opcion.remove();
                checkVictoria();
            } else {
                z.classList.add("incorrecto");
                setTimeout(() => z.classList.remove("incorrecto"), 600);
            }
        });
    });

    function checkVictoria() {
        const pendientes = document.querySelectorAll(".dropzone:not(.correcto)").length;
        if (pendientes === 0) {
            document.getElementById("victoria").classList.remove("hidden");
        }
    }
});
