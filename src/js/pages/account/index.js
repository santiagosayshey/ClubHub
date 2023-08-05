const { createApp, h } = require("vue");
import accountEdit from "../../vue/components/accountEdit.vue";

class AccountEdit {
    constructor() {
        const userId = document.querySelector("#account-edit").getAttribute("data-user-id");
        const app = createApp({
            render: () => h(accountEdit, { userId })
        });
        app.mount("#account-edit");

        this.logoutButton = document.querySelector('#logout');
        this.logoutButton.addEventListener('click', this.logout.bind(this));
    }

    logout() {
        const xhr = new XMLHttpRequest();
        xhr.open('GET', '/account/logout', true);

        xhr.onload = function() {
          if (xhr.status === 200) {
            window.location.href = "/login";
          } else {
          }
        };

        xhr.send();
      }
}

new AccountEdit();
