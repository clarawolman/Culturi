document.querySelectorAll(".opcion").forEach(op => {
    op.addEventListener("dragstart", e => {
        e.dataTransfer.setData("text", e.target.dataset.op);
    });
});

document.querySelectorAll(".dropzone").forEach(z => {
    z.addEventListener("dragover", e => e.preventDefault());

    z.addEventListener("drop", e => {
        e.preventDefault();

        const idOpcion = e.dataTransfer.getData("text");
        const opcion = document.querySelector(`[data-op='${idOpcion}']`);
        const id_oracion = opcion.dataset.oracion;
        const correcta = opcion.dataset.correcta === "true";

        const oracionDiv = z.closest(".oracion");
        const idOracionDiv = oracionDiv.dataset.id;

        if (id_oracion !== idOracionDiv) {
            z.classList.add("incorrecto");
            setTimeout(() => z.classList.remove("incorrecto"), 600);
            return;
        }

        if (correcta) {
            z.innerText = opcion.innerText;
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
