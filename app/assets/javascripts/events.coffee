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
      for i in [1..data_num]
        data.push(0)
        i += 1
      for value, index in row_data
        for key, value_single of value
          data[key] += value_single
      return data
    
    hashSort = (hash, key, order) ->
      if !order or order and !order.match(/^(ASC|DESC)$/i)
        order = 'ASC'
      if hash and key
        hash.sort (a, b) ->
          if order.match(/^ASC$/i)
            if a[key].toString() > b[key].toString()
              1
            else
              -1
          else
            if a[key].toString() < b[key].toString()
              1
            else
              -1
      return hash
      
    sort_data = (data, label) ->
      data_label_temp = []
      data_temp = []
      label_temp = []
      for value, index in data
        data_label_temp_single = {}
        data_label_temp_single.data = value
        data_label_temp_single.label = label[index]
        data_label_temp.push(data_label_temp_single)
      data_label_temp = hashSort(data_label_temp, 'data', 'DESC')
      for value, index in data_label_temp
        data_temp.push(value.data)
        label_temp.push(value.label)
      data_label = [data_temp, label_temp]
      return data_label
    
    sort_integrated_data = (data_past, data_future, label, order) ->
      data_label_temp = []
      past_data_temp = []
      future_data_temp = []
      label_temp = []
      for value, index in data_past
        data_label_temp_single = {}
        data_label_temp_single.past_data = value
        data_label_temp_single.future_data = data_future[index]
        data_label_temp_single.label = label[index]
        data_label_temp.push(data_label_temp_single)
      data_label_temp = hashSort(data_label_temp, order, 'DESC')
      for value, index in data_label_temp
        past_data_temp.push(value.past_data)
        future_data_temp.push(value.future_data)
        label_temp.push(value.label)
      data_label = [past_data_temp, future_data_temp, label_temp]
      return data_label      
    
    default_label = gon.default_label
    pattern_num = default_label.length
    
    row_past_data = get_past_row(gon.results)
    row_future_data = get_future_row(row_past_data, gon.proximal_results)
    
    past_data = get_data(row_past_data, pattern_num)
    past_sorted = sort_data(past_data, default_label)
    past_sorted_data = past_sorted[0]
    past_sorted_label = past_sorted[1]
    
    future_data = get_data(row_future_data, pattern_num)
    future_sorted = sort_data(future_data, default_label)
    future_sorted_data = future_sorted[0]
    future_sorted_label = future_sorted[1]
    
    integrated_past_sorted = sort_integrated_data(past_data, future_data, default_label, "past_data")
    integrated_past_sorted_past_data = integrated_past_sorted[0]
    integrated_past_sorted_future_data = integrated_past_sorted[1]
    integrated_past_sorted_label = integrated_past_sorted[2]
    
    integrated_future_sorted = sort_integrated_data(past_data, future_data, default_label, "future_data")
    integrated_future_sorted_past_data = integrated_future_sorted[0]
    integrated_future_sorted_future_data = integrated_future_sorted[1]
    integrated_future_sorted_label = integrated_future_sorted[2]
      
    all_data_num = row_past_data.length
    
    past_ctx = document.getElementById("past").getContext("2d")
    past_sorted_ctx = document.getElementById("past-sorted").getContext("2d")
    future_ctx = document.getElementById("future").getContext("2d")
    future_sorted_ctx = document.getElementById("future-sorted").getContext("2d")
    integrated_ctx = document.getElementById("integrated").getContext("2d")
    integrated_past_sorted_ctx = document.getElementById("integrated-sorted-past").getContext("2d")
    integrated_future_sorted_ctx = document.getElementById("integrated-sorted-future").getContext("2d")
    
    options = {
      responsive: false
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
      animation: false
      }
    
    pastChart = new Chart(past_ctx,
      type: 'horizontalBar'
      data:
        labels: default_label
        datasets: [
          data: past_data
          backgroundColor: "#428bd6"
        ]
      options: options
      )
      
    pastSortedChart = new Chart(past_sorted_ctx,
      type: 'horizontalBar'
      data:
        labels: past_sorted_label
        datasets: [
          data: past_sorted_data
          backgroundColor: "#428bd6"
        ]
      options: options
      )
    
    futureChart = new Chart(future_ctx,
      type: 'horizontalBar'
      data:
        labels: default_label
        datasets: [
          data: future_data
          backgroundColor: "#b0da6d"
        ]
      options: options
      )
    
    futureSortedChart = new Chart(future_sorted_ctx,
      type: 'horizontalBar'
      data:
        labels: future_sorted_label
        datasets: [
          data: future_sorted_data
          backgroundColor: "#b0da6d"
        ]
      options: options
      )
    
    integratedChart = new Chart(integrated_ctx,
      type: 'horizontalBar'
      data:
        labels: default_label
        datasets: [{
          data: past_data
          backgroundColor: "#428bd6"
        },{
          data: future_data
          backgroundColor: "#b0da6d"
        }]
      options: options
      )
    
    integratedPastChart = new Chart(integrated_past_sorted_ctx,
      type: 'horizontalBar'
      data:
        labels: integrated_past_sorted_label
        datasets: [{
          data: integrated_past_sorted_past_data
          backgroundColor: "#428bd6"
        },{
          data: integrated_past_sorted_future_data
          backgroundColor: "#b0da6d"
        }]
      options: options
      )
    
    integratedFutureChart = new Chart(integrated_future_sorted_ctx,
      type: 'horizontalBar'
      data:
        labels: integrated_future_sorted_label
        datasets: [{
          data: integrated_future_sorted_past_data
          backgroundColor: "#428bd6"
        },{
          data: integrated_future_sorted_future_data
          backgroundColor: "#b0da6d"
        }]
      options: options
      )