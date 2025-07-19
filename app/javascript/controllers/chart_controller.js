import { Controller } from "@hotwired/stimulus"
import { Chart } from "chart.js/auto"

export default class extends Controller {
  static targets = ["canvas"]
  static values = {
    labels: Array,
    data: Array,
    chartType: String // ← make sure this is defined
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
      type: this.hasChartTypeValue ? this.chartTypeValue : "bar", // ← use type dynamically
      data: {
        labels: this.labelsValue,
        datasets: [{
          label: "Chores",
          data: this.dataValue,
          backgroundColor: [
            "#3b82f6", "#10b981", "#f59e0b", "#ef4444", "#6366f1", "#14b8a6"
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
  }
}
