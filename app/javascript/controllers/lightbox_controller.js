import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'lightbox' ]

  toggle(event) {
    this.lightboxTarget.classList.toggle('d-none')
    event.preventDefault()
  }
}
