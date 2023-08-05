const { createApp, h } = require("vue");
import newPost from "../../vue/components/newPost.vue";
import newEvent from "../../vue/components/newEvent.vue";
import uploadBanner from "../../vue/components/uploadBanner.vue";
import uploadLogo from "../../vue/components/uploadLogo.vue";
import ClubEditComponent from "../../vue/components/clubEdit.vue";
import viewMembersComponent from "../../vue/components/manageClubUsers.vue";

class Club {
    constructor(clubId, cur) {
        this.clubId = clubId;
        this.cur = cur;
        this.targetUrl = '';
        this.joinButton = document.getElementById('joinButton');
        this.leaveButton = document.getElementById('leaveButton');
        this.registerDeletePostListeners();
        this.registerDeleteEventListeners();
        this.registerEventListeners();

        const updateApp = createApp({
            render: () => h(newPost, { clubID: Number(this.clubId) })
        });
        updateApp.mount("#add-update");

        const eventApp = createApp({
            render: () => h(newEvent, { clubID: Number(this.clubId) })
        });
        eventApp.mount("#add-event");

        const updateBanner = createApp({
            render: () => h(uploadBanner, { clubID: Number(this.clubId) }) // Pass clubId as a prop
        });
        updateBanner.mount("#update-banner");

        const updateLogo = createApp({
            render: () => h(uploadLogo, { clubID: Number(this.clubId) }) // Pass clubId as a prop
        });
        updateLogo.mount("#update-logo");

        const clubEditApp = createApp({
            render: () => h(ClubEditComponent, { clubID: Number(this.clubId) }) // Pass clubId as a prop
          });
        clubEditApp.mount("#club-edit");

        const viewMembers = createApp({
            render: () => h(viewMembersComponent, { clubID: Number(this.clubId), currentUserRole: String(this.cur) }) // Pass clubId as a prop
          });
        viewMembers.mount("#view-members");
    }

    updateMembershipStatus(newStatus) {
        let xhr = new XMLHttpRequest();
        xhr.open("POST", `/club/${this.clubId}/updateMembershipStatus`, true);
        xhr.setRequestHeader("Content-Type", "application/json");

        xhr.onload = () => {
            if (xhr.status == 200) {
                window.location.reload();
            }
        };

        const data = JSON.stringify({
            status: newStatus
        });

        xhr.send(data);
    }

    registerEventListeners() {
        this.joinButton.addEventListener('click', () => {
            this.joinButton.classList.add('hidden');
            this.leaveButton.classList.remove('hidden');
            this.updateMembershipStatus("Active");
        });

        this.leaveButton.addEventListener('click', () => {
            this.joinButton.classList.remove('hidden');
            this.leaveButton.classList.add('hidden');
            this.updateMembershipStatus("Inactive");
        });

        // Listen for changes to the email updates toggle
        document.getElementById('emailUpdatesToggle').addEventListener('change', (event) => {
            this.toggleEmailUpdates(event.target.checked);
        });

        // Listen for changes to the email events toggle
        document.getElementById('emailEventsToggle').addEventListener('change', (event) => {
            this.toggleEmailEvents(event.target.checked);
        });
    }

    deletePost(postId) {
        let xhr = new XMLHttpRequest();
        xhr.open("DELETE", `/club/${this.clubId}/post/${postId}`, true);
        xhr.setRequestHeader("Content-Type", "application/json");

        xhr.onload = () => {
            if (xhr.status == 200) {
                window.location.reload();
            }
        };

        xhr.send();
    }

    deleteEvent(eventId) {
        let xhr = new XMLHttpRequest();
        xhr.open("DELETE", `/club/${this.clubId}/event/${eventId}`, true);
        xhr.setRequestHeader("Content-Type", "application/json");

        xhr.onload = () => {
            if (xhr.status == 200) {
                window.location.reload();
            }
        };

        xhr.send();
    }


    registerDeletePostListeners() {
        const deleteButtons = document.querySelectorAll('.delete-post');
        deleteButtons.forEach((button) => {
            button.addEventListener('click', (event) => {
                const postId = event.currentTarget.getAttribute('data-post-id');

                // Get the modal
                var modal = document.getElementById('confirm-delete-post-modal');
                // Get the instance of the bootstrap modal
                var bsModal = new bootstrap.Modal(modal);
                // Show the modal
                bsModal.show();

                // Add a one-time event listener to the confirmation button
                document.getElementById('confirm-delete-post').addEventListener('click', () => {
                    this.deletePost(postId);
                    bsModal.hide();
                }, { once: true });
            });
        });
    }


    registerDeleteEventListeners() {
        const deleteButtons = document.querySelectorAll('.delete-event');
        deleteButtons.forEach((button) => {
            button.addEventListener('click', (event) => {
                event.preventDefault(); // Prevents the default action
                event.stopPropagation(); // Stops the event from bubbling up

                const eventId = event.currentTarget.getAttribute('data-event-id');

                // Get the modal
                var modal = document.getElementById('confirm-delete-event-modal');
                // Get the instance of the bootstrap modal
                var bsModal = new bootstrap.Modal(modal);
                // Show the modal
                bsModal.show();

                // Add a one-time event listener to the confirmation button
                document.getElementById('confirm-delete-event').addEventListener('click', () => {
                    this.deleteEvent(eventId);
                    bsModal.hide();
                }, { once: true });
            });
        });
    }

    toggleEmailUpdates(checked) {
        let xhr = new XMLHttpRequest();
        xhr.open("POST", `/club/${this.clubId}/email/update`, true);
        xhr.setRequestHeader("Content-Type", "application/json");

        xhr.onload = () => {
            if (xhr.status == 200) {
                this.showAlert('Email updates preference updated successfully.');
            } else {
                this.showAlert('An error occurred while updating your preferences. Please try again.');
            }
        };

        const data = JSON.stringify({
            opt_in_update: checked ? 1 : 0
        });

        xhr.send(data);
    }

    toggleEmailUpdates(checked) {
        let xhr = new XMLHttpRequest();
        xhr.open("POST", `/club/${this.clubId}/email/update`, true);
        xhr.setRequestHeader("Content-Type", "application/json");

        xhr.onload = () => {
            if (xhr.status == 200) {
                let message = checked ? 'Update emails were successfully enabled.' : 'Update emails were successfully disabled.';
                this.showAlert(message);
            }
        };

        const data = JSON.stringify({
            opt_in_update: checked ? 1 : 0
        });

        xhr.send(data);
    }

    toggleEmailEvents(checked) {
        let xhr = new XMLHttpRequest();
        xhr.open("POST", `/club/${this.clubId}/email/event`, true);
        xhr.setRequestHeader("Content-Type", "application/json");

        xhr.onload = () => {
            if (xhr.status == 200) {
                let message = checked ? 'Event emails were successfully enabled.' : 'Event emails were successfully disabled.';
                this.showAlert(message);
            }
        };

        const data = JSON.stringify({
            opt_in_event: checked ? 1 : 0
        });

        xhr.send(data);
    }

    showAlert(message) {
        let alertDiv = document.getElementById('alert');
        alertDiv.style.display = 'block';
        alertDiv.textContent = message;

        setTimeout(() => {
            alertDiv.style.display = 'none';
        }, 5000);
    }

}

window.addEventListener('DOMContentLoaded', (event) => {
    const clubId = document.getElementById('clubBanner').getAttribute('data-club-id');
    const cur = document.querySelector("#view-members").getAttribute("data-user-role");
    let handler = new Club(clubId, cur);
});
