const tabs = document.querySelectorAll('.tab');
const formLogin = document.getElementById('form-login');
const formRegister = document.getElementById('form-register');
const msg = document.getElementById('mensaje');

// Cambiar entre login y registro
tabs.forEach(tab => {
  tab.addEventListener('click', () => {
    tabs.forEach(t => t.classList.remove('active'));
    tab.classList.add('active');

    const target = tab.dataset.target;
    if (target === 'login') {
      formLogin.classList.add('active');
      formRegister.classList.remove('active');
    } else {
      formRegister.classList.add('active');
      formLogin.classList.remove('active');
    }

    msg.textContent = '';
  });
});

// ====== LOGIN ======
formLogin.addEventListener('submit', async (e) => {
  e.preventDefault();
  msg.style.color = 'black';
  msg.textContent = 'Verificando...';

  const body = {
    email: document.getElementById('login-email').value,
    password: document.getElementById('login-password').value
  };

  try {
    const res = await fetch('/api/auth/login', {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify(body)
    });

    const data = await res.json();

    if (!res.ok) throw new Error(data.message || 'Error al iniciar sesión');

    msg.style.color = 'green';
    msg.textContent = 'Sesión iniciada: ' + data.user.nombre;

  } catch (err) {
    msg.style.color = 'red';
    msg.textContent = err.message;
  }
});

// ====== REGISTRO ======
formRegister.addEventListener('submit', async (e) => {
  e.preventDefault();
  msg.style.color = 'black';
  msg.textContent = 'Creando cuenta...';

  const body = {
    nombre: document.getElementById('reg-nombre').value,
    email: document.getElementById('reg-email').value,
    password: document.getElementById('reg-password').value
  };

  try {
    const res = await fetch('/api/auth/register', {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify(body)
    });

    const data = await res.json();

    if (!res.ok) throw new Error(data.message || 'Error al registrarse');

    msg.style.color = 'green';
    msg.textContent = 'Cuenta creada, ahora inicia sesión.';

  } catch (err) {
    msg.style.color = 'red';
    msg.textContent = err.message;
  }
});
