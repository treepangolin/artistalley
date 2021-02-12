// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "stylesheets/application"
import "@popperjs/core"
import "bootstrap-icons/font/bootstrap-icons.css" // Use icons anywhere with <i class="bi-[icon]"></i>
import { Toast } from "bootstrap"

Rails.start()
ActiveStorage.start()

// When page completely loads, show toasts for flash messages
document.addEventListener("turbo:load", () => {
  var toastElList = [].slice.call(document.querySelectorAll('.toast'))
  var toastList = toastElList.map(function (toastEl) {
    return new Toast(toastEl)
  })

  toastList.forEach(toast => toast.show())
})

// import Stimulus controllers
import "controllers"
