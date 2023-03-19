import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="change-tab"
export default class extends Controller {
  static targets = ["tabList", "tabUsualItems", "list", "usualItems"];

  // connect() {
  //   console.log("The 'change-tab' controller is loaded");
	// 	console.log(this); // refers to the controller itself
	// 	console.log(this.element); // refers to element the controller is attached to
  //   console.log(this.listTarget);
  //   console.log(this.usualItemsTarget);
  // }

  showList(event) {
    event.preventDefault();
    this.listTarget.classList.remove("d-none");
    this.usualItemsTarget.classList.add("d-none");

    this.tabUsualItemsTarget.style.borderLeft = "2px solid rgba(0,0,0,0.3)";
    this.tabUsualItemsTarget.style.borderBottom = "2px solid rgba(0,0,0,0.3)";

    this.tabListTarget.style.borderRight = "none";
    this.tabListTarget.style.borderBottom = "none";
  }

  showUsualItems(event) {
    event.preventDefault();
    this.listTarget.classList.add("d-none");
    this.usualItemsTarget.classList.remove("d-none");

    this.tabUsualItemsTarget.style.borderLeft = "none";
    this.tabUsualItemsTarget.style.borderBottom = "none";

    this.tabListTarget.style.borderRight = "2px solid rgba(0,0,0,0.3)";
    this.tabListTarget.style.borderBottom = "1px solid rgba(0,0,0,0.3)";
  }
}
