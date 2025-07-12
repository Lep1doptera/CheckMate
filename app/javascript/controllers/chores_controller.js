import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["description", "checkbox", "chores"]

  moreInfo(event) {
    const choreCard = event.currentTarget.closest("[data-chores-target='chores']")
    const description = choreCard.querySelector("[data-chores-target='description']")
    if (description) {
      description.classList.toggle("hidden")
    }
  }

  checked(event) {
    const checkbox = event.currentTarget
    const choreCard = checkbox.closest("[data-chores-target='chores']")
    const completed = checkbox.checked
    const choreName = checkbox.nextElementSibling

    choreCard.classList.remove("bg-green-500", "bg-red-300", "bg-yellow-300", "bg-white")

    if (completed) {
      choreCard.classList.add("bg-green-500")
      choreName.classList.add("line-through")
    } else {
      choreName.classList.remove("line-through")

      const dueDateStr = choreCard.dataset.dateToBeCompleted

      if (dueDateStr) {
        const dueDate = new Date(dueDateStr)
        const today = new Date()
        const twoDaysFromNow = new Date()
        twoDaysFromNow.setDate(today.getDate() + 2)

        dueDate.setHours(0, 0, 0, 0)
        today.setHours(0, 0, 0, 0)
        twoDaysFromNow.setHours(0, 0, 0, 0)

        console.log(dueDateStr)

        if (dueDate < today) {
          choreCard.classList.add("bg-red-300")
        } else if (dueDate <= twoDaysFromNow) {
          choreCard.classList.add("bg-yellow-300")
        } else {
          choreCard.classList.add("bg-white")
        }
      } else {
        choreCard.classList.add("bg-white")
      }
    }

    const choreId = checkbox.dataset.choreId
    const token = document.querySelector('meta[name="csrf-token"]').content

    // Add animation class before making request
    choreCard.classList.add("chore-updating")

    // Delay the fetch to allow animation to show
    setTimeout(() => {
      fetch(`/chores/${choreId}`, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": token,
          "Accept": "text/vnd.turbo-stream.html"
        },
        body: JSON.stringify({
          chore: {
            completed: completed,
            completion_date: completed ? new Date().toISOString() : null
          }
        })
      })
      .then(response => response.text())
      .then(html => {
        Turbo.renderStreamMessage(html)
        setTimeout(() => {
          choreCard.classList.remove("chore-updating")
        }, 100)
      })
      .catch(error => {
        console.error("Error updating chore:", error)
        choreCard.classList.remove("chore-updating")
      })
    }, 600)
  }
}
