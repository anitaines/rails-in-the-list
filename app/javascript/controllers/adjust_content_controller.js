import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="adjust-content"
export default class extends Controller {
  connect() {
    // console.log(this.element.childElementCount);
    if (this.element.childElementCount == 1){
      this.element.style.justifyContent = "center";
    }
  }
}
