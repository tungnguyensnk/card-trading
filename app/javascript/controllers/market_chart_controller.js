import { Controller } from "@hotwired/stimulus"
import Chart from 'chart.js/auto';

export default class extends Controller {
  connect() {
    document.addEventListener("DOMContentLoaded", function () {
      const canvas = document.getElementById('marketChart');
      const ctx = canvas.getContext('2d');

      const gradient = ctx.createLinearGradient(0, 0, 0, canvas.height);
      gradient.addColorStop(0, "rgba(74, 153, 184, 0.5)");
      gradient.addColorStop(1, "rgba(74, 153, 184, 0)");

      const labels = [
        "1 Dec", "2 Dec", "3 Dec", "4 Dec", "5 Dec", "6 Dec", "7 Dec", "8 Dec", "9 Dec", "10 Dec",
        "11 Dec", "12 Dec", "13 Dec", "14 Dec", "15 Dec", "16 Dec", "17 Dec", "18 Dec", "19 Dec", "20 Dec",
        "21 Dec", "22 Dec", "23 Dec", "24 Dec", "25 Dec", "26 Dec", "27 Dec", "28 Dec", "29 Dec", "30 Dec"
      ];

      const dataPoints = [
        9, 12, 8, 14, 10, 11, 15, 9, 13, 7,
        14, 10, 12, 9, 13, 8, 14, 11, 12, 10,
        16, 9, 14, 7, 15, 8, 14, 10, 13, 9
      ];

      new Chart(ctx, {
        type: 'line',
        data: {
          labels: labels,
          datasets: [
            {
              label: "CT Market Price",
              data: dataPoints,
              borderColor: "#4a99b8",
              backgroundColor: gradient,
              tension: 0.4,
              fill: true,
              pointRadius: 0,
              pointHoverRadius: 6,
              pointBackgroundColor: "#007bff",
              pointBorderWidth: 2
            },
            // {
            //   label: "US Market Price",
            //   data: [null, null, null, null, null, null],
            //   borderColor: "#000",
            //   borderDash: [5, 5]
            // }
          ]
        },
        options: {
          responsive: true,
          plugins: {
            legend: { display: true, position: 'top' },
            tooltip: {
              mode: 'index',
              intersect: false,
              callbacks: {
                label: function(tooltipItem) {
                  return ` ${tooltipItem.dataset.label}: $${tooltipItem.raw.toFixed(2)}`;
                }
              }
            }
          },
          hover: {
            mode: 'nearest',
            intersect: false
          },
          scales: {
            x: {
              grid: { display: false },
              ticks: {
                callback: function (value, index) {
                  return index % 3 === 0 ? this.getLabelForValue(value) : "";
                }
              }
            },
            y: {
              grid: { display: false },
              beginAtZero: false,
              suggestedMin: 6,
              suggestedMax: 16,
              ticks: { callback: value => `$${value}` }
            }
          },
          interaction: {
            mode: 'index',
            intersect: false,
            axis: 'x'
          }
        }
      });
    });
  }
}
