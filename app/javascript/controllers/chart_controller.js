import { Controller } from "@hotwired/stimulus"
import { Chart } from "chart.js/auto"

export default class extends Controller {
  static targets = ["canvas","message"]
  static values = {
    labels: Array,
    data: Array,
    chartType: String
  }

  connect() {
    console.log("📊 Chart controller connected")
    console.log("Chart type:", this.chartTypeValue)

    const ctx = this.canvasTarget.getContext("2d")
    if (!ctx) {
      console.warn("Canvas context not found.")
      return
    }

    new Chart(ctx, {
      type: this.hasChartTypeValue ? this.chartTypeValue : "bar",
      data: {
        labels: this.labelsValue,
        datasets: [{
          label: "Chores",
          data: this.dataValue,
          backgroundColor: [
            "#06d6a0", "#ef476f", "#ffd166", "#118ab2", "#6366f1", "#073b4c"
          ],
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: 'bottom',
          }
        },
        scales: this.chartTypeValue === "doughnut" ? {} : {
          y: {
            beginAtZero: true
          }
        }
      }
    })
    this.checkAllChoresCompleted()
  }
    checkAllChoresCompleted() {
      const [completed, incomplete] = this.dataValue

      if (incomplete === 0 && this.hasMessageTarget) {
        this.messageTarget.classList.remove("hidden")
      }
    }
  }
