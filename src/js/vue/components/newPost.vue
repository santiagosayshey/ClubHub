<template>
  <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content">
          <div class="modal-header">
              <h1 class="modal-title fs-5" id="staticBackdropLabel">New Update</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
              <div class="mb-3">
                  <label for="title" class="form-label">Title</label>
                  <input type="text" class="form-control" id="title" placeholder="" v-model="updateDetails.title">
              </div>
              <div class="mb-3">
                  <label for="content" class="form-label">Content</label>
                  <div id="quillEditor" ref="editor"></div>
              </div>
          </div>
          <div class="modal-footer d-flex justify-content-between align-items-center">
              <div class="d-flex align-items-center">
                  <label class="switch mb-0">
                    <input type="checkbox" id="privatePost" v-model="updateDetails.private">
                    <span class="slider round"></span>
                  </label>
                  <label for="privatePost" class="form-label ms-2 mb-0">Private post (Visible to members only)</label>
              </div>
              <button type="button" class="btn btn-primary" @click="postUpdate">Add Update</button>
          </div>
      </div>
  </div>
</template>

<script>
import Quill from 'quill';

export default {
  data() {
    return {
      updateDetails: {
        title: "",
        content: "",
        private: false,
      },
      editor: null,
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
    postUpdate() {
      const title = this.updateDetails.title;
      const content  = this.editor.root.innerHTML;
      const privatePost = this.updateDetails.private;

      if (!title || !content.trim()) {
        alert('A title is required.');
        return;
      }

      // create a new object to send as a payload
      const payload = {
        title,
        content,
        private: privatePost,
      }
      // Assuming you have a prop clubID representing the current club
      const postUpdatePromise = new Promise((resolve, reject) => {
        const xhr = new XMLHttpRequest();
        xhr.open('POST', `/club/${this.clubID}/postUpdate`, true);
        xhr.setRequestHeader('Content-Type', 'application/json');

        xhr.onload = () => {
          if (xhr.status === 200) {
            resolve();
          } else {
            console.error(`Error posting update: status code ${xhr.status}`);
            reject();
          }
        };

        xhr.onerror = () => {
          console.error('Error occurred while making the request');
          reject();
        };
        xhr.send(JSON.stringify(payload)); // send payload instead of this.updateDetails
      });

      postUpdatePromise
        .then(() => {
          window.location.reload();
        })
        .catch(() => {
          console.error('There was an error posting the update');
        });
    },
  },
};
</script>