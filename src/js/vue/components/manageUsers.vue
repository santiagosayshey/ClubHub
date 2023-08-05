<template>
    <div class="alert alert-success" role="alert" v-if="showAlert">
        {{ alertMessage }}
    </div>
    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">
                        <div class="d-flex align-items-center">
                            <span>Email</span>
                            <select class="form-select form-select-sm ms-1 w-auto" v-model="sortField" @change="sortUsers">
                                <option disabled value="">Sort by</option>
                                <option value="emailAsc">Email Ascend</option>
                                <option value="emailDesc">Email Descend</option>
                            </select>
                        </div>
                    </th>
                    <th scope="col">
                        <div class="d-flex align-items-center">
                            <span>First Name</span>
                            <select class="form-select form-select-sm ms-1 w-auto" v-model="sortField" @change="sortUsers">
                                <option disabled value="">Sort by</option>
                                <option value="firstNameAsc">First Name Ascend</option>
                                <option value="firstNameDesc">First Name Descend</option>
                            </select>
                        </div>
                    </th>
                    <th scope="col">
                        <div class="d-flex align-items-center">
                            <span>Last Name</span>
                            <select class="form-select form-select-sm ms-1 w-auto" v-model="sortField" @change="sortUsers">
                                <option disabled value="">Sort by</option>
                                <option value="lastNameAsc">Last Name Ascend</option>
                                <option value="lastNameDesc">Last Name Descend</option>
                            </select>
                        </div>
                    </th>
                    <th scope="col">
                        <div class="d-flex align-items-center">
                            <span>Role</span>
                            <select class="form-select form-select-sm ms-1 w-auto" v-model="sortField" @change="sortUsers">
                                <option disabled value="">Sort by</option>
                                <option value="roleAsc">Role Ascend</option>
                                <option value="roleDesc">Role Descend</option>
                            </select>
                        </div>
                    </th>
                    <th scope="col">
                        <div class="d-flex align-items-center">
                            <button class="btn btn-info btn-sm" @click="resetSorting">
                                Reset Sort
                                <i class="bi bi-arrow-counterclockwise"></i>
                            </button>
                        </div>
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="user in users" :key="user.user_id">
                    <td>{{ user.email }}</td>
                    <td>{{ user.first_name }}</td>
                    <td>{{ user.last_name }}</td>
                    <td>
                        <select class="form-select form-select-sm" v-model="user.role">
                            <option value="Admin">Admin</option>
                            <option value="Member" :disabled="user.role === 'Admin'">Member</option>
                        </select>
                    </td>
                    <td>
                        <button type="button" class="btn btn-success" @click="updateUserRole(user)">Update Role</button>
                    </td>
                    <td>
                        <button type="button"
                                :class="user.status === 'Active' ? 'btn btn-danger' : 'btn btn-success'"
                                :disabled="user.role === 'Admin'"
                                @click="toggleAccountStatus(user)">
                                {{ user.status === 'Active' ? 'Disable' : 'Enable' }}
                        </button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                users: [],
                alertMessage: "message",
                showAlert: false,
                sortField: "",
            };
        },
        async created() {
            const response = await fetch('/manage/users', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
            });
            this.users = await response.json();
        },
        methods: {
            async updateUserRole(user) {
                await fetch('/manage/users/update', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        user_id: user.user_id,
                        role: user.role,
                    }),
                });
                this.alertMessage = "User Role has been updated";
                this.showAlert = true;
                setTimeout(() => {
                    this.showAlert = false;
                }, 5000);
            },
            sortUsers() {
                switch (this.sortField) {
                    case "emailAsc":
                        this.users.sort((a, b) => a.email.localeCompare(b.email));
                        break;
                    case "emailDesc":
                        this.users.sort((a, b) => b.email.localeCompare(a.email));
                        break;
                    case "firstNameAsc":
                        this.users.sort((a, b) => a.first_name.localeCompare(b.first_name));
                        break;
                    case "firstNameDesc":
                        this.users.sort((a, b) => b.first_name.localeCompare(a.first_name));
                        break;
                    case "lastNameAsc":
                        this.users.sort((a, b) => a.last_name.localeCompare(b.last_name));
                        break;
                    case "lastNameDesc":
                        this.users.sort((a, b) => b.last_name.localeCompare(a.last_name));
                        break;
                    case "roleAsc":
                        this.users.sort((a, b) => a.role.localeCompare(b.role));
                        break;
                    case "roleDesc":
                        this.users.sort((a, b) => b.role.localeCompare(a.role));
                        break;
                    default:
                        break;
                }
            },
            resetSorting() {
                this.sortField = ""; // Reset sortField to empty string
                this.users.sort((a, b) => a.first_name.localeCompare(b.first_name));
            },
            async toggleAccountStatus(user) {
                // If user is an admin, don't allow disabling
                if(user.role === 'Admin') {
                    this.alertMessage = "Admin account cannot be disabled";
                    this.showAlert = true;
                    setTimeout(() => {
                        this.showAlert = false;
                    }, 5000);
                    return;
                }

                const xhr = new XMLHttpRequest();
                const route = user.status === 'Active' ? '/manage/users/disable' : '/manage/users/enable';
                xhr.open('POST', route);
                xhr.setRequestHeader('Content-Type', 'application/json');
                xhr.onload = () => {
                    if (xhr.status === 200) {
                        user.status = user.status === 'Active' ? 'Inactive' : 'Active';
                        const status = user.status === 'Active' ? "enabled" : "disabled";
                        this.alertMessage = `User account has been ${status}`;
                        this.showAlert = true;
                        setTimeout(() => {
                            this.showAlert = false;
                        }, 5000);
                    }
                };
                xhr.send(JSON.stringify({ user_id: user.user_id }));
            },
        },
    };
</script>