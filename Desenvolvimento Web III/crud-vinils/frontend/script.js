const API = "http://localhost:3000/api/discs";

async function fetchDiscs() {
    const res = await fetch(API);
    const data = await res.json();
    const tbody = document.querySelector("#discs-table tbody");
    tbody.innerHTML = "";
    data.forEach((d) => {
        const tr = document.createElement("tr");
        tr.innerHTML = `
        <td>${d.title}</td>
        <td>${d.artist}</td>
        <td>${d.year || ""}</td>
        <td>${d.genre || ""}</td>
        <td>${d.format}</td>
        <td>${d.price != null ? Number(d.price).toFixed(2) : ""}</td>
        <td>
        <button data-id="${d._id}" class="edit">Editar</button>
        <button data-id="${d._id}" class="del">Excluir</button>
        </td>
    `;
        tbody.appendChild(tr);
    });
}

async function saveDisc(e) {
    e.preventDefault();
    const id = document.getElementById('disc-id').value;
    const payload = {
        title: document.getElementById('title').value,
        artist: document.getElementById('artist').value,
        year: document.getElementById('year').value || undefined,
        genre: document.getElementById('genre').value || undefined,
        format: document.getElementById('format').value,
        price: document.getElementById('price').value || undefined
    };


    if (id) {
        await fetch(`${API}/${id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });
    } else {
        await fetch(API, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });
    }


    resetForm();
    await fetchDiscs();
}

function resetForm() {
    document.getElementById('disc-id').value = '';
    document.getElementById('disc-form').reset();
}

async function handleTableClick(e) {
    const id = e.target.dataset.id;
    if (!id) return;
    if (e.target.classList.contains('edit')) {
        const res = await fetch(`${API}/${id}`);
        const d = await res.json();
        document.getElementById('disc-id').value = d._id;
        document.getElementById('title').value = d.title;
        document.getElementById('artist').value = d.artist;
        document.getElementById('year').value = d.year || '';
        document.getElementById('genre').value = d.genre || '';
        document.getElementById('format').value = d.format;
        document.getElementById('price').value = d.price || '';
    }
    if (e.target.classList.contains('del')) {
        if (confirm('Confirma exclusão?')) {
            await fetch(`${API}/${id}`, { method: 'DELETE' });
            await fetchDiscs();
        }
    }
}


document.getElementById('disc-form').addEventListener('submit', saveDisc);
document.getElementById('cancel-edit').addEventListener('click', resetForm);
document.querySelector('#discs-table tbody').addEventListener('click', handleTableClick);


fetchDiscs();