import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("hello");
  }

  // submitForm() {
  //   this.element.submit();
  // }
}
