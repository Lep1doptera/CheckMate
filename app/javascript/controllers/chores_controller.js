import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["description", "checkbox"]

  moreInfo(event) {
    const wrapper = event.currentTarget.closest("[data-controller='chores']")
    const choreCard = event.currentTarget.closest("[data-chores-target='chores']")
    const description = choreCard.querySelector("[data-chores-target='description']")
    if (description) {
      description.classList.toggle("hidden")
    }
  }

  checked(event) {
    const checkbox = event.currentTarget
    const choreId = checkbox.dataset.choreId
    const completed = checkbox.checked

    const token = document.querySelector('meta[name="csrf-token"]').content

    fetch(`/chores/${choreId}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": token,
        "Accept": "application/json"
      },
      body: JSON.stringify({
        chore: {
          completed: completed,
          completion_date: completed ? new Date().toISOString() : null
        }
      })
    })
    .then(response => {
      if (!response.ok) throw new Error("Network response was not ok")
      return response.json()
    })
    .then(data => {
      console.log("Chore updated:", data)

      // Visual line-through effect
      const choreName = checkbox.nextElementSibling
      if (completed) {
        choreName.classList.add("line-through", "text-gray-500")
      } else {
        choreName.classList.remove("line-through", "text-gray-500")
      }
    })
    .catch(error => {
      console.error("Error updating chore:", error)
    })
  }
}
