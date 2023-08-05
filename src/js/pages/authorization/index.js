class Login {
    constructor() {
        this.emailInput = document.getElementById('email');
        this.passwordInput = document.getElementById('password');
        this.loginButton = document.getElementById('login');
        this.loginButton.addEventListener('click', (event) => this.submitForm(event));
    }

    submitForm(event) {
        event.preventDefault();

        const email = this.emailInput.value;
        const password = this.passwordInput.value;

        const xhttp = new XMLHttpRequest();
        xhttp.open("POST", '/login/authenticate', true);
        xhttp.setRequestHeader('Content-Type', 'application/json');

        xhttp.onreadystatechange = function () {
            if (xhttp.readyState === 4 && xhttp.status === 200) {
                const response = JSON.parse(xhttp.responseText);
                if(response.redirect){
                    window.location.href = response.redirect;
                }
            } else if (xhttp.readyState === 4 && xhttp.status === 401) {
                const response = JSON.parse(xhttp.responseText);
                const errorMessage = encodeURIComponent(response.error);
                window.location.href = "/login?errorMessage=" + errorMessage;
            } else if (xhttp.readyState === 4 && xhttp.status === 403) {
                const response = JSON.parse(xhttp.responseText);
                const errorMessage = encodeURIComponent(response.error);
                window.location.href = "/login?errorMessage=" + errorMessage;
            }
        };
        const data = JSON.stringify({ email, password });
        xhttp.send(data);
    }
}
document.addEventListener('DOMContentLoaded', (event) => {
    const login = new Login();
});
