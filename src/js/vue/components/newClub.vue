<template>
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">Create New Club</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="clubName" class="form-label">Club Name</label>
                    <input type="text" class="form-control" id="clubName" v-model="clubData.club_name">
                </div>
                <div class="mb-3">
                    <label for="clubDescription" class="form-label">Club Description</label>
                    <textarea class="form-control" id="clubDescription" rows="3" v-model="clubData.club_description"></textarea>
                </div>
                    <div class="mb-3">
                    <label for="clubContact" class="form-label">Contact Information</label>
                    <input type="text" class="form-control" id="clubContact" v-model="clubData.contact_information">
                </div>
                <div class="mb-3">
                    <label for="clubInstagram" class="form-label">Instagram Handle</label>
                    <input type="text" class="form-control" id="clubInstagram" v-model="clubData.instagram_link">
                </div>
                <div class="mb-3">
                    <label class="form-label">Search Interests</label>
                    <input type="text" class="form-control" v-model="interestSearch" placeholder="Search interests...">
                    <label class="form-label mt-3">Club Interests</label>
                    <div class="interests-container" style="max-height: 300px; overflow-y: auto;">
                        <div
                            v-for="interest in filteredInterests"
                            :key="interest.interest_id"
                            :class="{ 'btn-primary': clubData.interests.includes(interest.interest_id), 'btn-outline-primary': !clubData.interests.includes(interest.interest_id) }"
                            @click="toggleInterest(interest.interest_id)"
                            class="interest-button btn m-1 btn-sm"
                            :data-interest="interest.interest_name"
                        >
                            {{ interest.interest_name }}
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" @click="postClub">Create Club</button>
            </div>
        </div>
    </div>
</template>

<script>
  export default {
    data() {
        return {
            clubData: {
                club_name: "",
                club_description: "",
                interests: [],
                contact_information: "",
                instagram_link: ""
            },
            interests: [],
            interestSearch: ""
        };
    },
    mounted() {
        this.getInterests();
    },
    computed: {
        filteredInterests() {
            if (this.interestSearch) {
                return this.interests.filter(interest => interest.interest_name.toLowerCase().includes(this.interestSearch.toLowerCase()));
            }
            return this.interests;
        }
    },
    methods: {
      toggleInterest(interest_id) {
        if (this.clubData.interests.includes(interest_id)) {
          this.clubData.interests = this.clubData.interests.filter(i => i !== interest_id);
        } else {
          this.clubData.interests.push(interest_id);
        }
      },
      getInterests() {
        const xhr = new XMLHttpRequest();
        xhr.open('GET', '/directory/interests', true);
        xhr.onload = () => {
          if (xhr.status === 200) {
            this.interests = JSON.parse(xhr.responseText);
          } else {
            console.error(`Error getting interests: status code ${xhr.status}`);
          }
        };
        xhr.onerror = () => {
          console.error('Error occurred while making the request');
        };
        xhr.send();
      },
      postClub() {
        const { club_name, club_description, interests, contact_information, instagram_link  } = this.clubData;
        if (!club_name || !club_description || !contact_information || !instagram_link) {
          alert('All fields are required.');
          return;
        }

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
          if (!emailRegex.test(contact_information)) {
              alert('Please enter a valid email address.');
              return;
          }

        // validate Instagram handle
        if (!instagram_link.startsWith('@')) {
            alert('Instagram handle must start with "@" character.');
            return;
        }

        if (interests.length === 0) {
            alert('At least one Interest must be selected.');
            return;
        }
        const payload = {
            club_name,
            club_description,
            interests,
            contact_information,
            instagram_link
        };
        const postClubPromise = new Promise((resolve, reject) => {
          const xhr = new XMLHttpRequest();
          xhr.open('POST', `/directory/new`, true);
          xhr.setRequestHeader('Content-Type', 'application/json');
          xhr.onload = () => {
            if (xhr.status === 200) {
                const response = JSON.parse(xhr.responseText);
                window.location.href = `/club/${response.newClubId}`;
            } else {
                console.error(`Error creating club: status code ${xhr.status}`);
                reject();
            }
          };
          xhr.onerror = () => {
            console.error('Error occurred while making the request');
            reject();
          };
          xhr.send(JSON.stringify(payload));
        });
        postClubPromise
          .then(() => {
            window.location.reload();
          })
          .catch(() => {
            console.error('There was an error creating the club');
          });
      },
    },
  };
</script>