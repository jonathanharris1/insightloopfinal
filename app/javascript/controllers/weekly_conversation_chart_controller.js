import { Controller } from "@hotwired/stimulus"
//import Chart from "chart.js/auto"

// data-controller="weekly-conversation-chart"
export default class extends Controller {
  static targets = ["canvas"]
  static values = {
    series: Object // { labels: [], datasets: [ {label, data, color} ] }
  }

  connect() {
    this.createChart()
  }

  disconnect() {
    if (this.chart) this.chart.destroy()
  }

  createChart() {
    const ctx = this.canvasTarget.getContext("2d")
    const { labels, datasets } = this.seriesValue

    const chartDatasets = datasets.map(ds => {
      const cssVar = getComputedStyle(document.documentElement)
        .getPropertyValue(ds.color)
        .trim()

      return {
        label: ds.label,
        data: ds.data,
        backgroundColor: this.withAlpha(cssVar || "#888", 0.85),
        borderColor: this.withAlpha(cssVar || "#888", 1),
        borderWidth: 0,
        borderRadius: 6,
        maxBarThickness: 44,    // limite
        categoryPercentage: 0.75,
        barPercentage: 0.7
      }
    })

    this.chart = new Chart(ctx, {
      type: "bar",
      data: {
        labels,
        datasets: chartDatasets
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: "bottom",
            labels: {
              boxWidth: 12,
              boxHeight: 12
            }
          },
          tooltip: {
            backgroundColor: getComputedStyle(document.documentElement)
              .getPropertyValue("--card"),
            borderColor: getComputedStyle(document.documentElement)
              .getPropertyValue("--border"),
            borderWidth: 1,
            cornerRadius: 8,
            padding: 10,
            displayColors: false
          }
        },
        scales: {
          x: {
            grid: {
              display: true,
              borderDash: [3, 3],
              color: "rgba(148, 163, 184, 0.3)"
            },
            ticks: {
              color: "hsl(var(--muted-foreground))",
              font: { size: 11 }
            }
          },
          y: {
            beginAtZero: true,
            grid: {
              borderDash: [3, 3],
              color: "rgba(148, 163, 184, 0.3)"
            },
            ticks: {
              color: "hsl(var(--muted-foreground))",
              font: { size: 11 },
              stepSize: 40
            }
          }
        }
      }
    })
  }

  withAlpha(color, alpha) {
    // espera algo tipo "hsl(var(--questions))" ou "rgb(...)"
    if (color.startsWith("rgb")) {
      return color.replace("rgb", "rgba").replace(")", `, ${alpha})`)
    }
    // fallback simples
    return color
  }
}
