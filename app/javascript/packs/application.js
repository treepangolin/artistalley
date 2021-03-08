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
import "@fortawesome/fontawesome-free/css/all"
import { Toast, Tooltip } from "bootstrap"

Rails.start()
ActiveStorage.start()

// When page completely loads, show toasts for flash messages
document.addEventListener("turbo:load", () => {
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new Tooltip(tooltipTriggerEl)
  })

  var toastElList = [].slice.call(document.querySelectorAll('.toast'))
  var toastList = toastElList.map(function (toastEl) {
    return new Toast(toastEl)
  })

  // Make all markdown-parsed links open in a new tab
  if (document.getElementById("markdown-area") !== null) {
    Array.from(
      document.getElementById("markdown-area").getElementsByTagName("a")
      ).forEach(link => link.target = "_blank")
  }

  toastList.forEach(toast => toast.show())
})

// import Stimulus controllers
import "controllers"
