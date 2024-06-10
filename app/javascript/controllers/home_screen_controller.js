import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["animation"];

  connect() {
    setTimeout(() => {
      this.animationTarget.classList.add("hidden");
    }, 5000);

    setTimeout(() => {
      this.animationTarget.remove();
      window.location.replace("/users");
    }, 5500);
  }
}
