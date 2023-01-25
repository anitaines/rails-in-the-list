import { Controller } from "@hotwired/stimulus"
import swal from 'sweetalert';

// Connects to data-controller="remove-user"
export default class extends Controller {
  static targets = ['removeUserForm', 'cancelInvitationForm', 'rejectInvitationForm'];

  // connect() {
  //   console.log('Hello from remove-user');
  //   console.log(this.cancelInvitationFormTargets);
  // }

  deleteUserList(event) {
    event.preventDefault();
    const question = event.currentTarget.dataset.question;

    swal({
      text: question,
      icon: "warning",
      buttons: ["No", "Yes"],
      dangerMode: true,
    })
    .then((willDelete) => {
      if (willDelete) {

        const url = this.removeUserFormTarget.action;

        fetch(url, {
          method: "DELETE",
          // headers: { "Accept": "text/plain" },
          headers: {"Accept": "application/json"}, // receives json from backend
          body: new FormData(this.removeUserFormTarget)
        })
        // .then(response => response.text())
        .then(response => response.json())
        .then((data) => {
          if (data.redirect == true){
            window.location.replace("/lists");
          } else {
            this.element.remove();
            swal("User has been removed", {
              icon: "success",
            });
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

  deleteInvitation(event) {
    event.preventDefault();
    const question = event.currentTarget.dataset.question;

    swal({
      text: question,
      icon: "warning",
      buttons: ["No", "Yes"],
      dangerMode: true,
    })
    .then((willDelete) => {
      if (willDelete) {

        const url = this.cancelInvitationFormTarget.action;

        fetch(url, {
          method: "DELETE",
          // headers: { "Accept": "text/plain" },
          headers: {"Accept": "application/json"}, // receives json from backend
          body: new FormData(this.cancelInvitationFormTarget)
        })
        // .then(response => response.text())
        .then(response => response.json())
        .then((data) => {
          if (data.invitation == 'deleted'){
            this.element.remove();

            swal("Invitation has been canceled", {
              icon: "success",
            });
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

  rejectInvitation(event) {
    event.preventDefault();
    const question = event.currentTarget.dataset.question;

    swal({
      text: question,
      icon: "warning",
      buttons: ["No", "Yes"],
      dangerMode: true,
    })
    .then((willDelete) => {
      if (willDelete) {

        const url = this.rejectInvitationFormTarget.action;

        fetch(url, {
          method: "DELETE",
          // headers: { "Accept": "text/plain" },
          headers: {"Accept": "application/json"}, // receives json from backend
          body: new FormData(this.rejectInvitationFormTarget)
        })
        // .then(response => response.text())
        .then(response => response.json())
        .then((data) => {
          if (data.invitation == 'deleted'){
            this.element.remove();

            swal("Invitation has been rejected", {
              icon: "success",
            });
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
