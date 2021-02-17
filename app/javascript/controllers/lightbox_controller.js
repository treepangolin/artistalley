import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'lightbox' ]

  toggle(event) {
    this.lightboxTarget.classList.toggle('d-none')
    event.preventDefault()
  }

  close(event) {
    if (event.key == 'Escape') {
      this.lightboxTarget.classList.add('d-none')
    }
  }
}
