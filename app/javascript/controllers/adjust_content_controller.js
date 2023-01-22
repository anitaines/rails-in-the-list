import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="adjust-content"
export default class extends Controller {
  static targets = ["adjust"];

  connect() {
    if (this.element.childElementCount == 2){
      this.adjustTarget.remove();
    }
  }
}
