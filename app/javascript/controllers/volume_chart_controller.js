// app/javascript/controllers/volume_chart_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["canvas"]
  static values = {
    labels: Array,
    values: Array
  }

  connect() {
    if (!window.Chart) return

    const ctx = this.canvasTarget.getContext("2d")
    const labels = this.labelsValue
    const dataValues = this.valuesValue

    if (this.chart) this.chart.destroy()

    this.chart = new Chart(ctx, {
      type: "line",
      data: {
        labels: labels,
        datasets: [{
          data: dataValues,
          fill: true,
          tension: 0.4,
          borderColor: "#f04438",
          backgroundColor: "rgba(240, 68, 56, 0.10)",
          pointRadius: 0,
          pointHitRadius: 12,
          borderWidth: 2
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        interaction: {
          mode: "index",
          intersect: false
        },
        hover: {
          mode: "index",
          intersect: false
        },

        plugins: {
          legend: { display: false },
          tooltip: {
            enabled: true,
            displayColors: false,
            backgroundColor: "#ffffff",
            titleColor: "#111827",
            bodyColor: "#111827",
            borderColor: "#e5e7eb",
            borderWidth: 1,
            shadowColor: "rgba(0,0,0,0.25)",
            shadowBlur: 8,
            usePointStyle: false,
            callbacks: {
              label: function(context) {
                const label = context.label || ""
                const value = context.formattedValue || "0"
                return `volume: ${value} conversas`
              }
            }
          }
        },
        scales: {
          x: {
            grid: { display: false }
          },
          y: {
            beginAtZero: true,
            grid: { color: "rgba(0, 0, 0, 0.04)" },
            ticks: { precision: 0 }
          }
        },
        animation: {
          duration: 800,
          easing: "easeInOutQuad"
        }
      }
    })
  }

  disconnect() {
    if (this.chart) this.chart.destroy()
  }
}
