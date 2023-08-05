<template>
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Club Members</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="alert alert-success" role="alert" v-if="showAlert">
                    {{ alertMessage }}
                </div>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Name</th>
                            <th scope="col">Email</th>
                            <th scope="col">Role</th>
                            <th scope="col">Action</th>
                            <th scope="col">Go to Page</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="member in clubMembers" :key="member.user_id">
                            <td>{{ member.first_name }} {{ member.last_name }}</td>
                            <td>{{ member.email }}</td>
                            <td>
                                <select class="form-select" v-model="member.role">
                                    <option value="Member">Member</option>
                                    <option value="Manager">Manager</option>
                                </select>
                            </td>
                            <td>
                                <button type="button" class="btn btn-success" @click="updateClubRole(member)">Update Role</button>
                            </td>
                            <td>
                                <button class="btn btn-link p-0" @click="gotoMemberPage(member.user_id)">
                                    <img
                                        :src="'/static/images/uploads/' + member.profile_picture"
                                        class="avatar navAvatar rounded-3 ms-3"
                                        style="width: 50px;"
                                        alt="Avatar"
                                        @error="setDefaultAvatar"
                                    >
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            clubMembers: [],
            showAlert: false,
            alertMessage: ''
        };
    },
    props: {
        clubID: {
            type: Number,
            required: true
        },
        currentUserRole: {
            type: String,
            required: true
        }
    },
    mounted() {
        this.getClubMembers();
    },
    methods: {
        getClubMembers() {
            const xhr = new XMLHttpRequest();
            xhr.open('GET', `/club/${this.clubID}/members`, true);
            xhr.onreadystatechange = () => {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    const response = JSON.parse(xhr.responseText);
                    this.clubMembers = response.members;
                } else if (xhr.readyState === 4) {
                    console.error('There was an error getting the club members');
                }
            };
            xhr.send();
        },
        async updateClubRole(member) {
            if (this.currentUserRole !== 'Admin' && member.role === 'Member') {
                this.alertMessage = 'Managers can not demote other managers.';
                this.showAlert = true;
                setTimeout(() => {
                    this.showAlert = false;
                }, 5000);
                return; // Don't continue with the request
            }

            // If it's not a manager trying to demote, continue with the request
            const response = await fetch(`/manage/users/${this.clubID}/update`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    user_id: member.user_id,
                    role: member.role,
                }),
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            this.alertMessage = 'User Role has been updated';
            this.showAlert = true;
            setTimeout(() => {
                this.showAlert = false;
            }, 5000);
        },
        gotoMemberPage(memberID) {
            window.location.href = `/account/${memberID}`;
        },
        setDefaultAvatar(event) {
            event.target.src = '/static/images/default_avatar.png';
        },
    }
};
</script>
