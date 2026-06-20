function abrirLightbox(img) {
    const lightbox = document.getElementById('lightbox');
    const lightboxImg = document.getElementById('lightbox-img');
    lightboxImg.src = img.src;
    lightbox.style.display = 'flex';
}

function fecharLightbox() {
    document.getElementById('lightbox').style.display = 'none';
}

// Validação simples do formulário
const form = document.getElementById('form-contato');
if (form) {
    form.addEventListener('submit', function(event) {
        const inputs = form.querySelectorAll('input[required], textarea[required]');
        for (const input of inputs) {
            if (!input.value.trim()) {
                alert('Por favor, preencha todos os campos.');
                input.focus();
                event.preventDefault();
                return false;
            }
        }
        return true;
    });
}
