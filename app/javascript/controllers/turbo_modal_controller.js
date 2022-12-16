import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-modal"
export default class extends Controller {
  static targets = ["modal"]

  hideModal() {
    this.element.parentElement.removeAttribute("src") // it might be nice to also remove the modal SRC
    this.element.remove()
  }

  // hide modal when clicking ESC
  // action: "keyup@window->turbo-modal#closeWithKeyboard"
  closeWithKeyboard(e) {
    if (e.code === "Escape") {
      this.hideModal()
    }
  }

  // hide modal when clicking outside of modal
  // action: "click@window->turbo-modal#closeBackground"
  closeBackground(e) {
    if (e && e.target.contains(this.modalTarget)) {
      this.hideModal()
    }
  }
}
