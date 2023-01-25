import { Controller } from "@hotwired/stimulus"
import swal from 'sweetalert';

// Connects to data-controller="sweet-alert"
export default class extends Controller {
  static targets = ['link'];

  /**
  * Display Sweet Alert to confirm Delete Action
  * <div data-controller="sweet-alert">
  *   <button type="button" data-action="click->sweet-alert#displayDeleteAlert">
  *     <i class="fa-solid fa-trash-can"></i>
  *     Delete List
  *   </button>
  *   <%= link_to "", foo_path(@foo), data: {turbo_method: :delete, sweet_alert_target: "link"}, class: "hidden" %>
  * </div>
  */   
  displayDeleteAlert() {
    swal({
      title: "Are you sure?",
      text: "This action cannot be reversed",
      buttons: ["No", "Yes"],
      dangerMode: true,
      icon: "warning"
    })
    .then((willDelete) => {
      if (willDelete) {
        this.linkTarget.click();
      }
    });
  }
}
