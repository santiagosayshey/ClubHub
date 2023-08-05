<template>
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Attendees</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Name</th>
                            <th scope="col">Email</th>
                            <th scope="col">Role</th>
                            <th scope="col">Go to Page</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="member in eventAttendees" :key="member.user_id">
                            <td>{{ member.first_name }} {{ member.last_name }}</td>
                            <td>{{ member.email }}</td>
                            <td>{{ member.role }}</td>
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
            eventAttendees: [],
        };
    },
    props: {
        eventID: {
            type: Number,
            required: true
        },
    },
    mounted() {
        this.getEventAttendees();
    },
    methods: {
        getEventAttendees() {
            const xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = () => {
                if (xhttp.readyState === 4 && xhttp.status === 200) {
                    const response = JSON.parse(xhttp.responseText);
                    this.eventAttendees = response.filter(attendee => attendee.rsvp_status === 'Going');
                }
            };
            xhttp.open("GET", "/events/" + this.eventID + "/attendees", true);
            xhttp.send();
        },
        gotoMemberPage(memberID) {
            window.location.href = `/account/${memberID}`;
        },
        setDefaultAvatar(event) {
            event.target.src = '/static/images/default_avatar.png';
        }
    }
};
</script>