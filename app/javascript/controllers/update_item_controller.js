import { Controller } from "@hotwired/stimulus"
import swal from 'sweetalert';

// Connects to data-controller="update-item"
export default class extends Controller {
  static targets = ['form', 'updating', 'deleteForm'];
  static values = {
    id: Number
  }

  // connect() {
  //   console.log("Hello from update item");
  //   console.log(this.element);
  //   console.log(this.formTarget);
  //   console.log(this.idValue);
  // }

  submitForm() {
    this.updatingTarget.classList.remove('d-none');

    const url = this.formTarget.action;

    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
    .then(response => response.json())
    .then((data) => {
      document.querySelector(`#item-${this.idValue}`).outerHTML = data.updated_item;

      document.querySelector(`#usual-item-${this.idValue}`).outerHTML = data.updated_usual_item;

      this.checkEmptyDisclaimer();
    })
  }

  deleteItem(event) {
    event.preventDefault();
    const itemName = this.deleteFormTarget.dataset.name;

    swal({
      text: `Delete ${itemName}?`,
      icon: "warning",
      buttons: ["No", "Yes"],
      dangerMode: true,
    })
    .then((willDelete) => {
      if (willDelete) {

        const url = this.deleteFormTarget.action;

        fetch(url, {
          method: "DELETE",
          // headers: { "Accept": "text/plain" },
          headers: {"Accept": "application/json"}, // receives json from backend
          body: new FormData(this.deleteFormTarget)
        })
        // .then(response => response.text())
        .then(response => response.json())
        .then((data) => {
          if (data.item == 'deleted'){
            this.element.remove();
            document.querySelector(`#item-${this.idValue}`).remove();

            this.checkEmptyDisclaimer();
          }
        })
        .catch(err => {
          if (err) {
            swal("Oh noes!", "Something went wrong, please refresh and try again", "error");
          } else {
            swal.stopLoading();
            swal.close();
          }
        });
      }
    });
  }

  checkEmptyDisclaimer() {
    const items = document.querySelectorAll('.item:not(.usual-item)');
    if (items.length == 0){
      document.querySelector('.list .empty').classList.remove('d-none');
    } else {
      document.querySelector('.list .empty').classList.add('d-none');
    }

    const usualItems = document.querySelectorAll('.usual-item');
    if (usualItems.length == 0){
      document.querySelector('.usual-items .empty').classList.remove('d-none');
    } else {
      document.querySelector('.usual-items .empty').classList.add('d-none');
    }
  }

}
