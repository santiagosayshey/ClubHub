class Login {
    constructor() {
        this.firstnameInput = document.getElementById('firstname');
        this.lastnameInput = document.getElementById('lastname');
        this.emailInput = document.getElementById('email');
        this.passwordInput = document.getElementById('password');
        this.loginButton = document.getElementById('login');
        this.loginButton.addEventListener('click', (event) => this.submitForm(event));
    }

    submitForm(event) {
        event.preventDefault();

        const firstname = this.firstnameInput.value;
        const lastname = this.lastnameInput.value;
        const email = this.emailInput.value;
        const password = this.passwordInput.value;

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            alert('Please enter a valid email address.');
            return;
        }

        if (firstname.trim() === '') {
            alert('Please enter a first name.');
            return;
        }

        if (lastname.trim() === '') {
            alert('Please enter a last name.');
            return;
        }

        if (password !== '' && password.length < 8) {
            alert('Password should be at least 8 characters long.');
            return;
        }

        const xhttp = new XMLHttpRequest();
        xhttp.open("POST", '/login/create', true);
        xhttp.setRequestHeader('Content-Type', 'application/json');

        xhttp.onreadystatechange = function () {
            if (xhttp.readyState === 4) {
                if (xhttp.status === 200) {
                    const response = JSON.parse(xhttp.responseText);
                    window.location.href = "/login";
                } else if (xhttp.status === 400) {
                    const response = JSON.parse(xhttp.responseText);
                    const errorMessage = encodeURIComponent(response.error);
                    window.location.href = "/login/create?errorMessage=" + errorMessage;
                } else {
                    window.location.href = "/login/create?errorMessage=\"An error occurred please try again later\"";
                }
            }
        };

        const data = JSON.stringify({
            firstname, lastname, email, password
        });
        xhttp.send(data);
    }

}
document.addEventListener('DOMContentLoaded', (event) => {
    const login = new Login();
});
