const { createApp, h } = require("vue");
import manageUsers from "../../vue/components/manageUsers.vue";

class ManageUser {
    constructor () {
        const app = createApp({
            render: () => h(manageUsers)
        });
        app.mount("#app");
    }
}
new ManageUser();
