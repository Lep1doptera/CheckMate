console.log("pie chart")
google.charts.load("current", {packages:["corechart"]});

document.addEventListener("turbo:load", function () {
  google.charts.setOnLoadCallback(() => {
    const choreValues = document.getElementById('donutchart');
    if (choreValues) {
      const chartData = JSON.parse(choreValues.dataset.chartvalues) || [] ;
      drawChart(chartData);
    }
  });
});


function drawChart(chartData) {
  const data = google.visualization.arrayToDataTable([
    ['Status', 'Chore'],
    ...chartData
  ]);

  var options = {
    title: '',
    pieHole: 0.4,
  };

  var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
  chart.draw(data, options);
}
