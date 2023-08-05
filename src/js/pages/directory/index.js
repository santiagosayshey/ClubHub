const { createApp, h } = require("vue");
import newClubCom from "../../vue/components/newClub.vue";

class Directory {
    constructor() {
        this.selectedInterests = [];
        this.interestButtons = document.querySelectorAll('.btn[data-interest]');
        this.clubs = document.querySelectorAll('.card[data-club-interests]');
        this.resetButton = document.querySelector('#reset-button');
        this.readMoreLinks = document.querySelectorAll('.read-more-link');
        this.searchBar = document.getElementById('search-bar');

        const newClub = createApp({
            render: () => h(newClubCom)
        });
        newClub.mount("#new-club");
    }

    init() {
        this.handleInterestButtonClick();
        this.handleResetButtonClick();
        this.handleReadMoreLinks();
        this.searchBar.addEventListener('input', () => this.handleSearchInput());
    }

    handleInterestButtonClick() {
        this.interestButtons.forEach((button) => {
            button.addEventListener('click', (e) => {
                this.toggleInterestButton(button, e.target.getAttribute('data-interest'));
                this.filterClubs();
            });
        });
    }

    toggleInterestButton(button, clickedInterest) {
        this.searchBar.value = '';

        if (button.classList.contains('btn-outline-primary')) {
            button.classList.remove('btn-outline-primary');
            button.classList.add('btn-primary');
            this.selectedInterests.push(clickedInterest);
        } else {
            button.classList.remove('btn-primary');
            button.classList.add('btn-outline-primary');
            const index = this.selectedInterests.indexOf(clickedInterest);
            if (index > -1) {
                this.selectedInterests.splice(index, 1);
            }
        }
    }

    filterClubs() {
        this.clubs.forEach((club) => {
            var clubInterests = club.getAttribute('data-club-interests').split(',');
            if (this.selectedInterests.length === 0 || clubInterests.some((interest) => this.selectedInterests.includes(interest))) {
                club.style.display = 'block';
            } else {
                club.style.display = 'none';
            }
        });
    }

    handleResetButtonClick() {
        this.resetButton.addEventListener('click', () => {
            this.resetClubsDisplay();
            this.resetSelectedInterests();
            this.resetInterestButtons();
        });
    }

    resetClubsDisplay() {
        this.clubs.forEach((club) => {
            club.style.display = 'block';
        });
    }

    resetSelectedInterests() {
        this.selectedInterests = [];
    }

    resetInterestButtons() {
        this.interestButtons.forEach((button) => {
            button.classList.remove('btn-primary');
            button.classList.add('btn-outline-primary');
        });
    }

    handleReadMoreLinks() {
        this.readMoreLinks.forEach((readMore) => {
            readMore.addEventListener('click', (e) => {
                e.preventDefault();
                this.toggleReadMoreText(readMore);
            });
        });
    }

    toggleReadMoreText(readMoreLink) {
        let moreText = readMoreLink.previousElementSibling;
        let ellipsis = moreText.previousElementSibling;
        if(moreText.classList.contains('hide')) {
            moreText.classList.remove('hide');
            moreText.classList.add('show');
            ellipsis.classList.remove('show');
            ellipsis.classList.add('hide');
            readMoreLink.textContent = 'Read Less';
        } else {
            moreText.classList.remove('show');
            moreText.classList.add('hide');
            ellipsis.classList.remove('hide');
            ellipsis.classList.add('show');
            readMoreLink.textContent = 'Read More';
        }
    }

    handleSearchInput() {
        // Reset the interests
        this.resetSelectedInterests();
        this.resetInterestButtons();

        // Get the search input
        const searchInput = this.searchBar.value;

        // Create a new XMLHttpRequest
        const xhttp = new XMLHttpRequest();

        xhttp.onreadystatechange = () => {
            if (xhttp.readyState === 4 && xhttp.status === 200) {
                // Parse the JSON response
                const clubData = JSON.parse(xhttp.responseText);

                // Filter the clubs
                this.filterClubsBySearch(clubData);
            }
        };

        // Configure and send the request
        xhttp.open("GET", `/directory/search?term=${encodeURIComponent(searchInput)}`, true);
        xhttp.send();
    }

    filterClubsBySearch(clubData) {
        // For each club in the page
        this.clubs.forEach((club) => {
            // Get the club's name
            const clubName = club.querySelector('.card-title').textContent;

            // If the club is in the response from the server
            if (clubData.some((responseClub) => responseClub.club_name === clubName)) {
                // Show the club
                club.style.display = 'block';
            } else {
                // Hide the club
                club.style.display = 'none';
            }
        });
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const directory = new Directory();
    directory.init();
});
