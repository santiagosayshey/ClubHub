<template>
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">Update Club Details</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="name" class="form-label">Club Name</label>
                    <input type="text" class="form-control" id="name" v-model="clubInfo.name">
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Club Description</label>
                    <input type="text" class="form-control" id="description" v-model="clubInfo.description">
                </div>
                <div class="mb-3">
                    <label for="contact" class="form-label">Contact Information</label>
                    <input type="contact" class="form-control" id="contact" aria-describedby="contactHelp" v-model="clubInfo.contact">
                </div>
                <div class="mb-3">
                    <label for="links" class="form-label">Instagram Link</label>
                    <input type="links" class="form-control" id="links" v-model="clubInfo.links">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" @click="updateClubInfo">Update</button>
            </div>
        </div>
    </div>
</template>

<script>
export default {
  data() {
    return {
      clubInfo: {
        name: "",
        description: "",
        contact: "",
        links: ""
      }
    };
  },
  props: {
    clubID: {
      type: Number,
      required: true
    }
  },
  mounted() {
    this.getClubInfo();
  },
  methods: {
    getClubInfo() {
      const xhr = new XMLHttpRequest();
      xhr.open('GET', `/club/${this.clubID}/getDetails`, true);
      xhr.onreadystatechange = () => {
          if (xhr.readyState === 4 && xhr.status === 200) {
              const response = JSON.parse(xhr.responseText);
              this.clubInfo.name = response.club.club_name;
              this.clubInfo.description = response.club.club_description;
              this.clubInfo.contact = response.club.contact_information;
              this.clubInfo.links = response.club.social_media_links;
              // Do not set the links from server response for security reasons.
          } else if (xhr.readyState === 4) {
              console.error('There was an error getting the club info');
          }
      };
      xhr.send();
    },

    updateClubInfo() {
      const { name, description, contact, links } = this.clubInfo;

      const contactRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!contactRegex.test(contact)) {
          alert('Please enter a valid contact address.');
          return;
      }

      if (name.trim() === '') {
          alert('Please enter a club name.');
          return;
      }

      if (description.trim() === '') {
          alert('Please enter a description.');
          return;
      }

      const updatedClubInfo = {
          name,
          description,
          contact,
          links
      };

      const xhr = new XMLHttpRequest();
      xhr.open('POST', `/club/${this.clubID}/updateDetails`, true);
      xhr.setRequestHeader('Content-Type', 'application/json');
      xhr.onreadystatechange = function () {
          if (xhr.readyState === 4) {
              if (xhr.status === 200) {
                window.location.reload();
              } else {
                  console.error('Error updating club details:', xhr.status);
              }
          }
      };
      xhr.send(JSON.stringify(updatedClubInfo));
    }
  }
};
</script>