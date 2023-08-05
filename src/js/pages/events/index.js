const { createApp, h, reactive } = require("vue");
import viewAttendeesComponent from "../../vue/components/viewAttendees.vue";

let eventAttendees = reactive([]);

class Events {
    constructor(eventID) {
        this.eventID = eventID;
        this.contentColumn = document.querySelector('.content-column');
        this.rsvpButton = document.querySelector('#rsvp-button');
        this.rsvpButton.addEventListener('click', this.updateRsvpStatus.bind(this));

        const viewAttendees = createApp({
            render: () => h(viewAttendeesComponent, { eventID: Number(this.eventID) }) // Pass clubId as a prop
          });
        viewAttendees.mount("#view-attendees");


    }

    updateRsvpStatus() {
        const xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = () => {
            if (xhttp.readyState === 4 && xhttp.status === 200) {
                // Toggle button color
                this.rsvpButton.classList.toggle('btn-success');
                this.rsvpButton.classList.toggle('btn-white');
                // Update button text
                this.rsvpButton.textContent = this.rsvpButton.classList.contains('btn-success') ? 'Going' : 'Not Going';
                // Update attendee count
                const response = JSON.parse(xhttp.responseText);
                const attendeeNumberSpan = document.querySelector('#attendee-number');
                attendeeNumberSpan.textContent = `${response.attendeeCount}`;
                window.location.reload();
            }
        };
        const newStatus = this.rsvpButton.textContent === 'Going' ? 'Not Going' : 'Going';
        xhttp.open('POST', '/events/' + this.eventID + '/rsvp', true);
        xhttp.setRequestHeader('Content-Type', 'application/json');
        xhttp.send(JSON.stringify({ rsvpStatus: newStatus }));
    }
}

document.addEventListener('DOMContentLoaded', (event) => {
    const eventID = document.getElementById('view-attendees').getAttribute('data-event-id');
    const events = new Events(eventID);
});
