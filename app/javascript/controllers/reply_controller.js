import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'form' ]

  toggle(event) {
    this.formTarget.classList.toggle('d-none')
    event.preventDefault()
  }
}
