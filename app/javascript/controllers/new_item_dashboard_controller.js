import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-item-dashboard"
export default class extends Controller {
  static targets = ["form", "card"];

  // connect() {
  //   console.log('Hello from new-item-dashboard');
  //   console.log(this.formTarget);
  // }

  displayForm(event) {
    event.preventDefault();
    this.formTarget.classList.remove("d-none");
  }

  hideForm() {
    this.formTarget.classList.add("d-none");
    
    const nameInput = this.formTarget.querySelector('#item_name');
    nameInput.setAttribute("value", "");
    nameInput.classList.remove('is-invalid');
    nameInput.removeAttribute("aria-invalid");
    nameInput.classList.remove('is-valid');

    const amountInput = this.formTarget.querySelector('#item_amount');
    amountInput.setAttribute("value", "");
    amountInput.classList.remove('is-invalid'); 
    amountInput.removeAttribute("aria-invalid");
    amountInput.classList.remove('is-valid');

    const commentInput = this.formTarget.querySelector('#item_comment');
    commentInput.innerText = "";
    commentInput.classList.remove('is-invalid');
    commentInput.removeAttribute("aria-invalid");
    commentInput.classList.remove('is-valid');

    const invalidFeedback = this.formTarget.querySelector('invalid-feedback');

    if (invalidFeedback) {
      invalidFeedback.forEach(e => e.remove());
    }
  }

  add(event) {
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
}
