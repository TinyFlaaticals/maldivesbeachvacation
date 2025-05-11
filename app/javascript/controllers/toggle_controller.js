import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["content"]

  toggle() {
    this.contentTarget.classList.toggle('h-0')
    this.contentTarget.classList.toggle('opacity-0')
    this.contentTarget.classList.toggle('h-auto')
    this.contentTarget.classList.toggle('opacity-100')
  }

}
