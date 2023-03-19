import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-item-list"
export default class extends Controller {
static targets = ["formNewItem", "formUsualItem", "formNewItemContainer", "formNewUsualItemContainer", "emptyListText", "emptyUsualItemstText", "item", "usualItem"];

  connect() {
    // console.log("Hello from new-item-list");
    this.checkEmptyDisclaimer();
  }

  addNewItem(event) {
    event.preventDefault();

    const url = this.formNewItemTarget.action;

    fetch(url, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formNewItemTarget)
    })
    .then(response => response.json())
    .then((data) => {
      if (data.inserted_item) {
        this.formNewItemContainerTarget.insertAdjacentHTML("beforebegin", data.inserted_item);
        this.formNewItemContainerTarget.outerHTML = data.form_new_item;
        this.formNewUsualItemContainerTarget.insertAdjacentHTML("beforebegin", data.inserted_usual_item);
      } else if (data.form_failed_item) {
        this.formNewItemContainerTarget.outerHTML = data.form_failed_item;
      }

      this.checkEmptyDisclaimer();
    })
  }

  addNewUsualItem(event) {
    event.preventDefault();

    const url = this.formUsualItemTarget.action;

    fetch(url, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formUsualItemTarget)
    })
    .then(response => response.json())
    .then((data) => {
      if (data.inserted_usual_item) {
        this.formNewItemContainerTarget.insertAdjacentHTML("beforebegin", data.inserted_item);

        this.formNewUsualItemContainerTarget.outerHTML = data.form_new_item;
        this.formNewUsualItemContainerTarget.insertAdjacentHTML("beforebegin", data.inserted_usual_item);
      } else if (data.form_failed_item) {
        this.formNewUsualItemContainerTarget.outerHTML = data.form_failed_item;
      }

      this.checkEmptyDisclaimer();
    })
  }

  checkEmptyDisclaimer() {
    if (this.itemTargets.length == 0){
      this.emptyListTextTarget.classList.remove('d-none');
    } else {
      this.emptyListTextTarget.classList.add('d-none');
    }

    if (this.usualItemTargets.length == 0){
      this.emptyUsualItemstTextTarget.classList.remove('d-none');
    } else {
      this.emptyUsualItemstTextTarget.classList.add('d-none');
    }
  }
}
