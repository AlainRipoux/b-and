import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["animation", "content", "filters"];

  connect() {
    setTimeout(() => {
      this.animationTarget.classList.add("hidden");
      this.contentTarget.classList.add("visible");
      this.filtersTarget.classList.add("visible");
    }, 3000);

    setTimeout(() => {
      this.animationTarget.remove();
    }, 4000);
  }
}
