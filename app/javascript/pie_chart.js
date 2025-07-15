console.log("pie chart loaded");
google.charts.load("current", { packages: ["corechart"] });

document.addEventListener("turbo:load", function () {
  google.charts.setOnLoadCallback(() => {
    // Handle household chart
    const householdChart = document.getElementById("household-donutchart");
    if (householdChart) {
      const chartData = JSON.parse(householdChart.dataset.chartvalues || "[]");
      drawChart(chartData, "household-donutchart");
    }

    // Handle user chart
    const userChart = document.getElementById("user-donutchart");
    if (userChart) {
      const chartData = JSON.parse(userChart.dataset.chartvalues || "[]");
      drawChart(chartData, "user-donutchart");
    }
  });
});

function drawChart(chartData, chartId) {
  const data = google.visualization.arrayToDataTable([
    ["Status", "Chore"],
    ...chartData,
  ]);

  const options = {
    title: "",
    pieHole: 0.4,
  };

  const chart = new google.visualization.PieChart(document.getElementById(chartId));
  chart.draw(data, options);
}
