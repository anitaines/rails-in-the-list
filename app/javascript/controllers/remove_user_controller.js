import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="remove-user"
export default class extends Controller {
  // static targets = ['removeUserForm'];

  // connect() {
  //   console.log('Hello from remove-user');
  //   console.log(this.removeUserFormTarget);
  // }

  deleteUserList(event) {
    event.preventDefault();
    const question = event.currentTarget.dataset.question;

    if (confirm(question)){
      
      const url = event.currentTarget.action;

      fetch(url, {
        method: "DELETE",
        // headers: { "Accept": "text/plain" },
        headers: {"Accept": "application/json"}, // receives json from backend
        body: new FormData(event.currentTarget)
      })
        // .then(response => response.text())
        .then(response => response.json())
        .then((data) => {
          if (data.redirect == true){
            window.location.replace("/lists");
          } else {
            this.element.remove();
          }
        })
    }
  }

  deleteInvitation(event) {
    event.preventDefault();
    const question = event.currentTarget.dataset.question;

    if (confirm(question)){
      
      const url = event.currentTarget.action;

      fetch(url, {
        method: "DELETE",
        // headers: { "Accept": "text/plain" },
        headers: {"Accept": "application/json"}, // receives json from backend
        body: new FormData(event.currentTarget)
      })
        // .then(response => response.text())
        .then(response => response.json())
        .then((data) => {
          if (data.invitation == 'deleted'){
            this.element.remove();
          }
        })
    }
  }
}
