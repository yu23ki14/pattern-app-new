$(document).on 'turbolinks:load', ->
  if $("body").hasClass("graph")
    get_past_row = (past_row_data) ->
      past_data = []
      for value, index in past_row_data
        past_data.push(JSON.parse(value))
      return past_data
    
    get_future_row = (past_data, proximal_data) ->
      future_data = []
      for value, index in past_data
        future_data_single = {}
        parsed_future_data = JSON.parse(proximal_data[index])
        for key, value_single of value
          future_data_single[key] = parsed_future_data[key] - value_single
        future_data.push(future_data_single)
      return future_data
      
    get_data = (row_data, data_num) ->
      data = []
      for i in [0..data_num]
        data.push(0)
        i += 1
      for value, index in row_data
        for key, value_single of value
          data[key] += value_single
      console.log data
      return data
    
    default_label = gon.default_label
    pattern_num = default_label.length
    
    row_past_data = get_past_row(gon.results)
    row_future_data = get_future_row(row_past_data, gon.proximal_results)
    past_data = get_data(row_past_data, pattern_num)
    future_data = get_data(row_future_data, pattern_num)
    
    all_data_num = row_past_data.length
    
    past_ctx = document.getElementById("past").getContext("2d")
    integrated_ctx = document.getElementById("integrated").getContext("2d")
    
    options = {
      responsive: false
      layout:
        padding:
          left: 50
          right: 50
          top: 50
          bottom: 50
      legend:
        display: false
      scales:
        yAxes: [
          stacked: true
          categoryPercentage: 0.5
          gridLines:
            offsetGridLines: true
          ticks:
            fontSize: 10
            padding: 20
          ]
        xAxes: [
          stacked: true
          categoryPercentage: 0.5
          ticks:
            beginAtZero: true
            min: 0
            max: all_data_num    
            padding: 20
          gridLines:
            lineWidth: 2
          ]
          
      }
    
    pastChart = new Chart(past_ctx,
      type: 'horizontalBar'
      data:
        labels: default_label
        datasets: [
          data: past_data
          backgroundColor: "#E5EDC7"
        ]
      options: options
      )
    
    integratedChart = new Chart(integrated_ctx,
      type: 'horizontalBar'
      data:
        labels: default_label
        datasets: [{
          data: past_data
          backgroundColor: "#E5EDC7"
        },{
          data: future_data
          backgroundColor: "#DAF0FC"
        }]
      options: options
      )