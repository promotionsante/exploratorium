// https://gist.github.com/chrisjhoughton/7890303
// Wait for something to be ready before executing a function
var waitForEl = function(selector, callback) {
    if (jQuery(selector).length) {
        callback();
    } else {
        setTimeout(function() {
            waitForEl(selector, callback);
        }, 100);
    }
};

Shiny.addCustomMessageHandler('remove_id_if_existing_in_dom', function(message) {

  dom_object = $("#" + message)

   if (dom_object.length) {
        dom_object.remove()
    }
});


Shiny.addCustomMessageHandler('display_warning_no_available_projects', function(message) {

  dom_object = $("#" + message)

   if (dom_object.length) {
        dom_object.html(
          "<p>Aucun projet ne répond à ces critères de sélection</p>" +
          "<p>Kein Projekt erfüllt diese Auswahlkriterien</p>"
          )
    }
});

Shiny.addCustomMessageHandler('createBarChart', function(message) {

  waitForEl(
    "#" + message[0].id,
    function(){
        var data = message;
        console.log(data);
        createBarChart(data);
    }
  )

});

function countKeysMatchingPattern(obj, pattern) {
  const regex = new RegExp(pattern);
  let count = 0;

  for (const key in obj) {
    if (regex.test(key)) {
      count++;
    }
  }

  return count;
}

function createBarChart(data) {

  const data_to_compare = data[0].data_to_compare;

  var chartData = Object.keys(data_to_compare).map(place_to_compare => ({
    name: data_to_compare[place_to_compare].name,
    y: data_to_compare[place_to_compare].value,
    value_tooltip: data_to_compare[place_to_compare].value_tooltip
  }));

  const number_items = countKeysMatchingPattern(data_to_compare, "place")
  const colorsArray = Array.from({ length: number_items }, () => '#f59300');

  chartData.forEach((placeData, index) => {
   placeData.color = colorsArray[index];
  });

  const id = data[0].id;
  const axis_max = data[0].plot_options.axis_max;
  const axis_interval = data[0].plot_options.axis_interval;
  const x_axis_labels = JSON.parse(data[0].plot_options.x_axis_labels);
  const font_size_labels_col = data[0].plot_options.font_size_labels_col;
  const series_name = data[0].plot_options.series_name;
  const prefixer = data[0].plot_options.prefixer;

  Highcharts.chart(id, {
    chart: {
      type: 'bar',
      height: 234,
      backgroundColor: 'rgba(0, 0, 0, 0)'
    },
    title: {
      text: ''
    },
    plotOptions: {
      bar: {
        pointPadding: 0.1,
        groupPadding: 0
      }
    },
    xAxis: {
      type: 'category',
      labels: {
        style: {
          fontSize: '14px',
          color: '#000000' ,
          fontFamily: 'DINPro',
          fontWeight: 'lighter'
        }
      }
    },
    yAxis: {
      type: 'linear',
      max: axis_max,
      tickInterval: axis_interval,
      title: {
        text: ''
      },
      labels: {
        enabled: x_axis_labels,
        style: {
          fontSize: '10px',
          color: '#000000',
          fontFamily: 'DINPro',
          fontWeight: 'lighter'
        },
        formatter: function () {
          return this.value + prefixer;
        }
      }
    },
    plotOptions: {
      bar: {
        pointPadding: 1, // Adjust the spacing between bars within a group
    groupPadding: 0.1, // Adjust the spacing between groups
        pointWidth: 20,
        dataLabels: {
          enabled: true,
          inside: false,
          style: {
            fontFamily: 'DINPro',
            fontSize: font_size_labels_col,
            fontWeight: 'bold',
            color: '#000000'
          },
          formatter: function() {
            return Highcharts.numberFormat(this.y, 0, ".", " ") + prefixer;
          }
        }
      }
    },
    tooltip: {
      style: {
        fontFamily: 'DINPro',
        fontSize: '12px' // Set the font size for the tooltip
      },
      formatter: function() {
        return `${this.point.value_tooltip}`;
      }
    },
    series: [{
      name: series_name,
      data: chartData
    }],
    accessibility: {
      enabled: true
    },
    legend: {
      enabled: false
    },
    credits: {
      enabled: false
    },
    exporting: {
      enabled: false
    },
  });
}

Shiny.addCustomMessageHandler('createLineChart', function(message) {

  waitForEl(
    "#" + message[0].id,
    function(){
        var data = message;
        console.log(data);
        createLineChart(data);
    }
  )

});

function createLineChart(data) {

  const data_to_compare = data[0].data_to_compare;

  var chartData = Object.keys(data_to_compare).map(place_to_compare => ({
    name: data_to_compare[place_to_compare].name,
    y: data_to_compare[place_to_compare].value,
    value_tooltip: data_to_compare[place_to_compare].value_tooltip
  }));

  const number_items = countKeysMatchingPattern(data_to_compare, "place");
  const colorsArray = Array.from({ length: number_items }, () => '#f59300');

  chartData.forEach((placeData, index) => {
    placeData.color = colorsArray[index];
  });

  const id = data[0].id;
  const axis_max = data[0].plot_options.axis_max;
  const axis_interval = data[0].plot_options.axis_interval;
  const x_axis_labels = JSON.parse(data[0].plot_options.x_axis_labels);
  const font_size_labels_col = data[0].plot_options.font_size_labels_col;
  const series_name = data[0].plot_options.series_name;
  const prefixer = data[0].plot_options.prefixer;

  Highcharts.chart(id, {
    chart: {
      type: 'area',
      height: 234,
      backgroundColor: 'rgba(0, 0, 0, 0)'
    },
    title: {
      text: ''
    },
    plotOptions: {
      line: { // Adjust the options specific to line chart
        lineWidth: 2, // Set the width of the line
        marker: {
          enabled: true, // Show data points as markers
          radius: 4 // Set the radius of the markers
        },
        color: '#f59300'
      },
      area: {
        color: '#f59300',
        fillColor: {
          linearGradient: { x1: 0, x2: 0, y1: 0, y2: 1 },
          stops: [
             [0, '#f59300'], // Start color (orange)
             [1, 'rgba(245, 147, 0, 0.4)'] // End color with 0 opacity (transparent)
          ]
        }
      }
    },
    xAxis: {
      type: 'category',
      labels: {
        style: {
          fontSize: '14px',
          color: '#000000',
          fontFamily: 'DINPro',
          fontWeight: 'lighter'
        }
      }
    },
    yAxis: {
      type: 'linear',
      max: axis_max,
      tickInterval: axis_interval,
      title: {
        text: ''
      },
      labels: {
        enabled: x_axis_labels,
        style: {
          fontSize: '10px',
          color: '#000000',
          fontFamily: 'DINPro',
          fontWeight: 'lighter'
        },
        formatter: function() {
          return Highcharts.numberFormat(this.value, 0, ".", " ") + prefixer;
        }
      }
    },
    tooltip: {
      style: {
        fontFamily: 'DINPro',
        fontSize: '12px' // Set the font size for the tooltip
      },
      formatter: function() {
        return `${this.point.value_tooltip}`;
      }
    },
    series: [{
      name: series_name,
      data: chartData
    }],
    accessibility: {
      enabled: true
    },
    legend: {
      enabled: false
    },
    credits: {
      enabled: false
    },
    exporting: {
      enabled: false
    },
  });
}
