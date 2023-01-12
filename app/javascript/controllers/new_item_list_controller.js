import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-item-list"
export default class extends Controller {
  static targets = ["form", "li", "emptyListText", "item"];

  connect() {
    // console.log("Hello from new-item-list");
    if (this.itemTargets.length == 0){
      this.emptyListTextTarget.classList.remove('d-none');
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
        this.liTarget.outerHTML = data;

        if (this.itemTargets.length > 0){
          this.emptyListTextTarget.classList.add('d-none');
        }
      })
  }
}
