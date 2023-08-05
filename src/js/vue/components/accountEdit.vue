<template>
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">Update Account Info</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="formFile" class="form-label">Image Upload</label>
                    <input class="form-control" type="file" id="formFile" @change="onFileChange">
                </div>
                <div class="mb-3">
                    <label for="firstname" class="form-label">First Name</label>
                    <input type="text" class="form-control" id="firstname" v-model="accountInfo.firstname">
                </div>
                <div class="mb-3">
                    <label for="lastname" class="form-label">Last Name</label>
                    <input type="text" class="form-control" id="lastname" v-model="accountInfo.lastname">
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email address</label>
                    <input type="email" class="form-control" id="email" aria-describedby="emailHelp" v-model="accountInfo.email">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" v-model="accountInfo.password">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" @click="updateAccount">Update</button>
            </div>
        </div>
    </div>
</template>

<script>
export default {
  data() {
    return {
      accountInfo: {
        firstname: "",
        lastname: "",
        email: "",
        password: ""
      },
      imageFile: null
    };
  },
  props: {
    userId: {
      type: String,
      required: true
    }
  },
  mounted() {
    this.getAccountInfo();
  },
  methods: {
    getAccountInfo() {
        const xhr = new XMLHttpRequest();
        xhr.open('GET', '/account/getAccountInfo', true);
        xhr.onreadystatechange = () => {
            if (xhr.readyState === 4 && xhr.status === 200) {
                const response = JSON.parse(xhr.responseText);
                this.accountInfo.firstname = response.user.first_name;
                this.accountInfo.lastname = response.user.last_name;
                this.accountInfo.email = response.user.email;
                // Do not set the password from server response for security reasons.
            } else if (xhr.readyState === 4) {
                console.error('There was an error getting the user info');
            }
        };
        xhr.send();
    },

    onFileChange(event) {
      this.imageFile = event.target.files[0];
    },

    updateAccount() {
    const { firstname, lastname, email, password } = this.accountInfo;

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        alert('Please enter a valid email address.');
        return;
    }

    if (firstname.trim() === '') {
        alert('Please enter a first name.');
        return;
    }

    if (lastname.trim() === '') {
        alert('Please enter a last name.');
        return;
    }

    if (password !== '' && password.length < 8) {
        alert('Password should be at least 8 characters long.');
        return;
    }

    const updatedAccountInfo = {
        firstname,
        lastname,
        email,
        password: password !== '' ? password : undefined
    };

    const updateInfoPromise = new Promise((resolve, reject) => {
    const xhr = new XMLHttpRequest();
    xhr.open('POST', '/account/updateAccountInfo', true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            resolve();
        }
        if(xhr.readyState == 4 && xhr.status !== 200) {
            const response = JSON.parse(xhr.responseText);
            reject(response.error);
        }
    };
    xhr.send(JSON.stringify(updatedAccountInfo));
});

    const updateImagePromise = this.imageFile ? new Promise((resolve, reject) => {
    const photoXhr = new XMLHttpRequest();
    photoXhr.open('POST', `/account/uploadProfileImage`, true);


    photoXhr.onload = () => {
        if (photoXhr.status == 200) {
            resolve();
        } else {
            console.error(`Error uploading image: status code ${photoXhr.status}`);
            reject();
        }
    };

    photoXhr.onerror = () => {
        console.error('Error occurred while making the request');
        reject();
    };

    photoXhr.upload.onprogress = (event) => {
        if (event.lengthComputable) {
            const percentage = (event.loaded / event.total) * 100;
        }
    };

    const photoFormData = new FormData();
    photoFormData.append('file', this.imageFile);
    photoXhr.send(photoFormData);
    }) : Promise.resolve();



    Promise.all([updateInfoPromise, updateImagePromise])
        .then(() => {
            window.location.reload();
        })
        .catch((error) => {
            alert(error);
            console.error('There was an error updating the information or image');
        });
    }

  }
};
</script>