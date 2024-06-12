import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="invite-button"
export default class extends Controller {
  connect() {
    console.log("hello hello")
  }

  disable(event) {
    this.element.innerText = "Invited !";
    this.element.setAttribute("disabled", "");
  }
}
