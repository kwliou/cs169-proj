$.histogram = function(container_id, opts) {
   chart = new Highcharts.Chart({
      chart: {
         renderTo: container_id,
         defaultSeriesType: 'column',
		 plotShadow: true
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
				 font: 'normal 10px Verdana, sans-serif'
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

$.performance = function(container_id, opts) {
	if (opts.x_axis.length < 1) {
		return
	}
	chart = new Highcharts.Chart({
		chart: {
			renderTo: container_id,
			defaultSeriesType: 'spline',
			marginRight: 130,
			marginBottom: 25
		},
		title: {
			text: 'Overall Performance',
			x: -20 //center
		},
		xAxis: {
			categories: opts.x_axis,
			labels: {
				rotation: -20,
				align: 'right',
				style: {
					font: 'normal 10px Verdana, sans-serif'
				}
			}
		},
		yAxis: {
			title: {
				text: 'Average Score (%)'
			},
			plotLines: [{
				value: 0,
				width: 1,
				color: '#808080'
			}]
		},
		tooltip: {
			formatter: function() {
	                return '<b>'+ this.series.name +'</b><br/>'+
					this.x +': '+ this.y +'%';
			}
		},
		legend: {
			layout: 'vertical',
			align: 'right',
			verticalAlign: 'top',
			x: -10,
			y: 100,
			borderWidth: 0
		},
		series: [{
			name: 'My Performance',
			data: opts.my_performance
		}, {
			name: 'Class Performance',
			data: opts.class_performance
		}]
	});
}
