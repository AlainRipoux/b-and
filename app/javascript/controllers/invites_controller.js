import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="invites"
export default class extends Controller {
  static targets = [ "accept", "decline", "lign"]

  updateAccept(event) {
    event.preventDefault()
    const url = this.acceptTarget.href
      fetch(url, {
        method: "PATCH",
        headers: {"Accept": "text/plain"}
        })
      .then(response => response.text())
      .then((data) => {
        this.element.outerHTML = data
      })
  }

  updateDecline(event) {
    event.preventDefault()
    const url = this.declineTarget.href
    console.log(this.lignTarget);
    console.log(this.declineTarget.href);
      fetch(url, {
        method: "PATCH",
        headers: {"Accept": "text/plain"}
        })
      .then(response => response.text())
      .then((data) => {
        console.log(data)
        this.element.outerHTML = data
      })
  }
}
