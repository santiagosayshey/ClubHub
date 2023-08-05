<template>
  <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content">
          <div class="modal-header">
              <h1 class="modal-title fs-5" id="staticBackdropLabel">New Event</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
              <div class="mb-3">
                  <label for="eventName" class="form-label">Event Name</label>
                  <input type="text" class="form-control" id="eventName" placeholder="" v-model="eventDetails.eventName">
              </div>
              <div class="mb-3">
                  <label for="eventSubtitle" class="form-label">Event Subtitle</label>
                  <input type="text" class="form-control" id="eventSubtitle" placeholder="" v-model="eventDetails.eventSubtitle">
              </div>
              <div class="mb-3">
                  <label class="form-label">Event Description</label>
                  <div id="quillEditor" ref="editor"></div>
              </div>
              <div class="mb-3">
                  <label for="eventDate" class="form-label">Event Date</label>
                  <input type="date" class="form-control" id="eventDate" v-model="eventDetails.eventDate">
              </div>
              <div class="mb-3">
                  <label for="eventTime" class="form-label">Event Time</label>
                  <input type="time" class="form-control" id="eventTime" v-model="eventDetails.eventTime">
              </div>
              <div class="mb-3">
                <label class="form-label">Event Location</label>
                <div id="eventLocation">
                  <div class="row">
                    <div class="col-md-6 mb-3">
                      <input type="text" class="form-control" id="eventRoom" placeholder="Room" v-model="eventDetails.eventRoom">
                    </div>
                    <div class="col-md-6 mb-3">
                      <input type="text" class="form-control" id="eventBuilding" placeholder="Building" v-model="eventDetails.eventBuilding">
                    </div>
                    <div class="col-md-12 mb-3">
                      <input type="text" class="form-control" id="eventStreet" placeholder="Street Address" v-model="eventDetails.eventStreet">
                    </div>
                    <div class="col-md-12 mb-3">
                      <input type="text" class="form-control" id="eventCampus" placeholder="Campus" v-model="eventDetails.eventCampus">
                    </div>
                  </div>
                </div>
              </div>
              <div class="mb-3">
                  <label for="eventOrganizerInfo" class="form-label">Event Organizer Info</label>
                  <textarea class="form-control" id="eventOrganizerInfo" rows="4" v-model="eventDetails.eventOrganizerInfo"></textarea>
              </div>
          </div>
          <div class="modal-footer d-flex justify-content-between align-items-center">
              <div class="d-flex align-items-center">
                  <label class="switch mb-0">
                    <input type="checkbox" id="privatePost" v-model="eventDetails.isPrivate">
                    <span class="slider round"></span>
                  </label>
                  <label for="privatePost" class="form-label ms-2 mb-0">Private Event (Visible to members only)</label>
              </div>
              <button type="button" class="btn btn-primary" @click="addEvent">Add Event</button>
          </div>
      </div>
  </div>
</template>

<script>
import Quill from 'quill';
export default {
  data() {
    return {
      eventDetails: {
      eventName: "",
      eventSubtitle: "",
      eventDate: "",
      eventTime: "",
      eventRoom: "",
      eventBuilding: "",
      eventStreet: "",
      eventCampus: "",
      eventDescription: "",
      eventOrganizerInfo: "",
      isPrivate: false
    },
      quill: null
    };
  },
  props: {
    clubID: {
      type: Number,
      required: true
    }
  },
  mounted() {
    this.editor = new Quill(this.$refs.editor, {
      theme: 'snow',
      modules: {
        toolbar: [
          ['bold', 'italic', 'underline', 'strike'], // toggled buttons
          ['blockquote'], // blocks
          [{ 'header': 1 }, { 'header': 2 }], // custom button values
          [{ 'list': 'ordered'}, { 'list': 'bullet' }], // lists
          ['link', 'image'], // add link and image support
          ['clean'], // remove formatting
        ]
      }
    });
  },
  methods: {
    addEvent() {
      const location = `${this.eventDetails.eventRoom}, ${this.eventDetails.eventBuilding}, ${this.eventDetails.eventStreet}, ${this.eventDetails.eventCampus}`;
      const title = this.eventDetails.eventName;
      const subtitle = this.eventDetails.eventSubtitle;
      const description  = this.editor.root.innerHTML;
      const date = this.eventDetails.eventDate;
      const time = this.eventDetails.eventTime;
      const organizerInfo = this.eventDetails.eventOrganizerInfo;
      const isPrivate = this.eventDetails.isPrivate;

      if (!title || !description.trim() || !location || !subtitle || !date || !time || !organizerInfo || isPrivate === undefined) {
          alert('All fields are required.');
          return;
      }

      // Create a new object to send as a payload
      const payload = {
        eventName: title,
        eventSubtitle: subtitle,
        eventDate: date,
        eventTime: time,
        eventLocation: location,
        eventDescription: description,
        eventOrganizerInfo: organizerInfo,
        isPrivate: isPrivate
      };

      const xhr = new XMLHttpRequest();
      xhr.open("POST", `/club/${this.clubID}/addEvent`, true);
      xhr.setRequestHeader("Content-Type", "application/json");

      xhr.onload = () => {
        if (xhr.status === 200) {
          window.location.reload();
        } else {
          console.error(`Error adding event: status code ${xhr.status}`);
          console.error(xhr.responseText);
        }
      };

      xhr.onerror = () => {
        console.error("Error occurred while making the request");
      };

      xhr.send(JSON.stringify(payload));
    }
  }
};
</script>
