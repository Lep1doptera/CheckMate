import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="auth"
export default class extends Controller {
  connect() { console.log('hello')
  }
  static targets = ["loginForm", "signupForm"]

  openLogin() {
    this.loginFormTarget.classList.remove("hidden")
    this.signupFormTarget.classList.add("hidden")
    this.element.classList.remove("hidden")
  }

  openSignup() {
    this.signupFormTarget.classList.remove("hidden")
    this.loginFormTarget.classList.add("hidden")
    this.element.classList.remove("hidden")
  }

  close() {
    this.element.classList.add("hidden")
  }
}
