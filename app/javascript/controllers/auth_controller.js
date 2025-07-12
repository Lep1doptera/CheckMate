import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="auth"
export default class extends Controller {
  connect() { console.log('hello')
  }
  static targets = ["loginForm", "signupForm", "authModal"]

  openLogin() {
    this.authModalTarget.classList.remove("hidden")
    this.loginFormTarget.classList.remove("hidden")
    this.signupFormTarget.classList.add("hidden")

  }

  openSignup() {
    this.authModalTarget.classList.remove("hidden")
    this.signupFormTarget.classList.remove("hidden")
    this.loginFormTarget.classList.add("hidden")
  }

  close() {
    this.authModalTarget.classList.add("hidden")
  }
}
