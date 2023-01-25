import { Controller } from "@hotwired/stimulus"
import swal from 'sweetalert';

// Connects to data-controller="update-item"
export default class extends Controller {
  static targets = ['form', 'updating', 'deleteForm'];

  // connect() {
  //   console.log("Hello from update item");
  // }

  submitForm() {
    this.updatingTarget.classList.remove('d-none');

    const url = this.formTarget.action;

    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.element.outerHTML = data;
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

            const items = document.querySelectorAll('.item');
            if (items.length == 0){
              document.querySelector('.list .empty').classList.remove('d-none');
            }  
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

}
