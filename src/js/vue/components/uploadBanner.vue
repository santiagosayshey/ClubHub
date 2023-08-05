<template>
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">Upload Banner</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="formFile" class="form-label">Image Upload</label>
                    <input class="form-control" type="file" id="formFile" @change="onFileChange">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" @click="uploadImage">Confirm</button>
            </div>
        </div>
    </div>
</template>

<script>
export default {
  data() {
    return {
      imageFile: null
    };
  },
  props: {
    clubID: {
      type: Number,
      required: true
    }
  },
  methods: {
    onFileChange(event) {
      const file = event.target.files[0];
      if (!file.type.startsWith('image/')){ // check if file is an image based on its MIME type
        alert('Please select an image file.');
        return;
      }
      this.imageFile = file;
    },
    uploadImage() {
      if (!this.imageFile) {
        alert('No image file selected.');
        return;
      }

      const uploadImagePromise = new Promise((resolve, reject) => {
        const xhr = new XMLHttpRequest();
        xhr.open('POST', `/club/${this.clubID}/uploadBanner`, true);
        xhr.onload = () => {
          if (xhr.status == 200) {
            resolve();
          } else {
            console.error(`Error uploading image: status code ${xhr.status}`);
            reject();
          }
        };

        xhr.onerror = () => {
          console.error('Error occurred while making the request');
          reject();
        };

        xhr.upload.onprogress = (event) => {
          if (event.lengthComputable) {
            const percentage = (event.loaded / event.total) * 100;
          }
        };

        const formData = new FormData();
        formData.append('file', this.imageFile);
        xhr.send(formData);
      });

      uploadImagePromise
        .then(() => {
          window.location.reload();
        })
        .catch(() => {
          console.error('There was an error uploading the image');
        });
    }
  }
};
</script>

