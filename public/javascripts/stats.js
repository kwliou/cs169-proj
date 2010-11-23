$.histogram = function(container_id, opts) {
   chart = new Highcharts.Chart({
      chart: {
         renderTo: container_id,
         defaultSeriesType: 'column'
      },
      title: {
         text: opts.title
      },
      subtitle: {
         text: opts.subtitle
      },
      xAxis: {
         categories: opts.categories,
		labels: {
			rotation: -45,
			align: 'right',
			style: {
				 font: 'normal 13px Verdana, sans-serif'
			}
		}
      },
      yAxis: {
         min: 0,
         title: {
            text: 'Frequency'
         }
      },
      tooltip: {
         formatter: function() {
            return this.x + ':'+ this.y;
         }
      },
      plotOptions: {
         column: {
            pointPadding: 0.2,
            borderWidth: 1
         }
      },
      series: [{
         name: 'Score Range',
         data: opts.points
   
      }]
   });
}