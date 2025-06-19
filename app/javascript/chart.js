import Chart from 'chart.js/auto';

document.addEventListener("turbo:load", function () {
  const ctx = document.getElementById("radarChart");
  if (ctx) {
    new Chart(ctx, {
      type: 'radar',
      data: {
        labels: ["甘さ", "爽やかさ", "華やかさ", "落ち着き", "スパイシー", "セクシー"],
        datasets: [{
          label: "香りの印象（例）",
          data: [3, 4, 2, 5, 1, 3],
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)',
          borderWidth: 1
        }]
      },
      options: {
        scales: {
          r: {
            min: 0,
            max: 5,
            ticks: {
              stepSize: 1
            }
          }
        }
      }
    });
  }
});
