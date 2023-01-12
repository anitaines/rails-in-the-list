import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-invitation"
export default class extends Controller {
  static targets = ["form", "card", "users"];

  // connect() {
  //   console.log("Hello from new-invitation");
  // }

  displayForm() {
    this.formTarget.classList.remove("d-none");
  }

  hideForm() {
    this.formTarget.classList.add("d-none");
    
    const emailInput = this.formTarget.querySelector('#invitation_invitation_to_id');
    emailInput.value = '';
    emailInput.classList.remove('is-invalid');
    emailInput.classList.remove('is-valid');
    emailInput.removeAttribute("aria-invalid");

    const messageInput = this.formTarget.querySelector('#invitation_message');
    messageInput.value = '';
    messageInput.classList.remove('is-invalid');
    messageInput.classList.remove('is-valid');
    messageInput.removeAttribute("aria-invalid");

    const invalidFeedback = this.formTarget.querySelector('invalid-feedback');

    if (invalidFeedback) {
      invalidFeedback.forEach(e => e.remove());
    }
  }

  sendFromDashboard(event) {
    event.preventDefault();

    const url = this.formTarget.action;

    fetch(url, {
      method: "POST",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.cardTarget.outerHTML = data;
      })
  }

  sendFromList(event) {
    event.preventDefault();

    const url = this.formTarget.action;

    fetch(url, {
      method: "POST",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.usersTarget.innerHTML = data;
      })
  }
}
