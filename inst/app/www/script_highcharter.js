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


Shiny.addCustomMessageHandler('createChart', function(message) {

  waitForEl(
    "#" + message[0].id,
    function(){
        var data = message;
        console.log(data);
        createChart(data);
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

function createChart(data) {

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
  const series_name = data[0].plot_options.series_name;
  const prefixer = data[0].plot_options.prefixer;

  Highcharts.chart(id, {
    chart: {
      type: 'bar',
      height: 234,
      backgroundColor: 'rgba(0, 0, 0, 0)',
      events: {
        load: function() {
          var dataLabelsOfPoints = this.series[0].points,
            correctedPosition;

          dataLabelsOfPoints.forEach(function(el, inx) {
            if (el.graphic.element.attributes[3].value > el.dataLabel.x) {
              correctedPosition = parseInt($(el.dataLabel.div).css("top"));
              correctedPosition -= 25;
              correctedPosition = correctedPosition + 'px';

              $(el.dataLabel.div).css('top', correctedPosition);
            }
          });
        }
      }
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
        dataLabels: {
          enabled: true,
          inside: false,
          style: {
            fontFamily: 'DINPro',
            fontSize: '16px',
            fontWeight: 'bold',
            color: '#000000'
          },
          formatter: function() {
            return this.y + prefixer;
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
