import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["description"]

  moreInfo(event) {
    const wrapper = event.currentTarget.closest("[data-controller='chores']")
    const choreCard = event.currentTarget.closest("[data-chores-target='chores']")
    const description = choreCard.querySelector("[data-chores-target='description']")
    if (description) {
      description.classList.toggle("hidden")
    }
  }
}
