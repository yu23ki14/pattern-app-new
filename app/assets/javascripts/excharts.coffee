$(document).on 'turbolinks:load', ->
  if $("body").hasClass("new")
    allcard = $(".card").length
    allcards = $(".card").length
    single_span = ($(".progressbar-outline").width() - 24) / allcards
    max_bar_width = $(".progressbar-outline").width() - 2
    bar_width = $(".js-trigger-bar").width()
    element = document.getElementById('card' + allcard)
    new_data1 = {}
    new_data2 = {}
    
    setNext = (id) ->
      element = document.getElementById('card' + id)

    Bar_forwarding = ->
      bar_width = 24 + single_span * (allcards - allcard + 1)
      $(".js-trigger-bar").css("width", bar_width)
    
    roop = (direction) ->
      if direction == "right"
        $("#card" + allcard).css('transform', 'translate(105vw, 0) rotate(-5deg)')
        pattern_no = $("#card" + allcard).attr('pattern_no')
        new_data1[pattern_no] = 1
        $("#exchart_data1").val(JSON.stringify(new_data1))
        new_data2[pattern_no] = 1
        $("#exchart_data2").val(JSON.stringify(new_data2))
      else if direction == "left"
        $("#card" + allcard).css('transform', 'translate(-105vw, 0) rotate(5deg)')
        pattern_no = $("#card" + allcard).attr('pattern_no')
        new_data1[pattern_no] = 0
        $("#exchart_data1").val(JSON.stringify(new_data1))
        new_data2[pattern_no] = 0
        $("#exchart_data2").val(JSON.stringify(new_data2))
      else if direction == "up"
        $("#card" + allcard).css('transform', 'translate(0, -155vw) rotate(-5deg)')
        pattern_no = $("#card" + allcard).attr('pattern_no')
        new_data1[pattern_no] = 0
        $("#exchart_data1").val(JSON.stringify(new_data1))
        new_data2[pattern_no] = 1
        $("#exchart_data2").val(JSON.stringify(new_data2))
      Bar_forwarding()
      allcard = allcard - 1
      if allcard != 0
        setNext(allcard)
        base()
      else
        $("input[type='submit']").css("display", "block")
    
    base = ->
      hammertime = new Hammer(element)
      hammertime.get('swipe').set
        direction: Hammer.DIRECTION_ALL
        threshold: 1
        velocity: 0.1
      hammertime.on 'swipeleft', ->
        roop("left")
      hammertime.on 'swiperight', ->
        roop("right")
      hammertime.on 'swipeup', ->
        roop("up")
  
    base()
    
  if $("body").hasClass("excharts show")
    patterns = gon.patterns
    ctx = document.getElementById("myChart").getContext("2d")
    
    #データの成形
    original_data1 = JSON.parse(gon.data1)
    original_data2 = JSON.parse(gon.data2)
    data_length = Object.keys(original_data1).length
    data1 = []
    data2 = []
    
    for i in [1..data_length] by 3
      d1 = original_data1[i] + original_data1[i+1] + original_data1[i+2]
      data1.push(d1)
      d2 = original_data2[i] + original_data2[i+1] + original_data2[i+2]
      data2.push(d2)
      
    #ラベル
    label = gon.label.split(',')
    
    #チャートのオプション
    options = {scale:
                display: true
                pointLabels:
                  display: true
                  fontSize: 11
                ticks:
                  stepSize: 1
                  beginAtZero: true
                  display: false
                  
              legend:
                display: false
              }
                
    #チャート生成
    myChart = new Chart(ctx,
      type: 'radar'
      data:
        labels: label
        datasets: [ {
          data: data1
          pointRadius:0
          pointHitRadius:20
          backgroundColor: "rgba(243, 158, 155, 0.5)"
          borderColor: "#F39E9B"
          borderWidth: 1
        },{
          data: data2
          pointRadius:0
          pointHitRadius:20
          backgroundColor: "rgba(243, 158, 155, 0.5)"
          borderColor: "#F39E9B"
          borderWidth: 1
        } ]
      options: options)
    
    #ラベルクリック
    $('#myChart').click (e) ->
      helpers = Chart.helpers
      eventPosition = helpers.getRelativePosition(e, myChart.chart)
      mouseX = eventPosition.x
      mouseY = eventPosition.y
      activePoints = []
      # loop through all the labels
      helpers.each myChart.scale.ticks, ((label, index) ->
        i = @getValueCount() - 1
        while i >= 0
          # here we effectively get the bounding box for each label
          pointLabelPosition = @getPointPosition(i, @getDistanceFromCenterForValue(if @options.reverse then @min else @max) + 5)
          pointLabelFontSize = helpers.getValueOrDefault(@options.pointLabels.fontSize, Chart.defaults.global.defaultFontSize)
          pointLabeFontStyle = helpers.getValueOrDefault(@options.pointLabels.fontStyle, Chart.defaults.global.defaultFontStyle)
          pointLabeFontFamily = helpers.getValueOrDefault(@options.pointLabels.fontFamily, Chart.defaults.global.defaultFontFamily)
          pointLabeFont = helpers.fontString(pointLabelFontSize, pointLabeFontStyle, pointLabeFontFamily)
          ctx.font = pointLabeFont
          labelsCount = @pointLabels.length
          halfLabelsCount = @pointLabels.length / 2
          quarterLabelsCount = halfLabelsCount / 2
          upperHalf = i < quarterLabelsCount or i > labelsCount - quarterLabelsCount
          exactQuarter = i == quarterLabelsCount or i == labelsCount - quarterLabelsCount
          width = ctx.measureText(@pointLabels[i]).width + 20
          height = pointLabelFontSize + 20
          x = undefined
          y = undefined
          if i == 0 or i == halfLabelsCount
            x = pointLabelPosition.x - (width / 2)
          else if i < halfLabelsCount
            x = pointLabelPosition.x
          else
            x = pointLabelPosition.x - width
          if exactQuarter
            y = pointLabelPosition.y - (height / 2)
          else if upperHalf
            y = pointLabelPosition.y - height
          else
            y = pointLabelPosition.y
          # check if the click was within the bounding box
          if mouseY >= y and mouseY <= y + height and mouseX >= x and mouseX <= x + width
            activePoints.push
              index: i
              label: @pointLabels[i]
          i--
        return
      ), myChart.scale
      firstPoint = activePoints[0]
      if firstPoint != undefined
        $("#pattern_list").modal()
        $(".js-place-pattern-list").empty()
        for i in [1..3]
          pattern = patterns[(firstPoint.index * 3) + i]
          $(".js-place-pattern-list").append('<a href="/patterns/' + pattern.language_id + '/' + pattern.pattern_no + '"><p class="row-space-2">・' + pattern.pattern_name + '</p></a>')
      return
    
    $(document).on 'click', '.js-trigger-switch-proximal', ->
      $(this).removeClass("in-active")
      $(".js-trigger-switch-current").addClass("in-active")
      $(".proximal-patterns-container").css("display", "block")
      $(".current-patterns-container").css("display", "none")
    
    $(document).on 'click', '.js-trigger-switch-current', ->
      $(this).removeClass("in-active")
      $(".js-trigger-switch-proximal").addClass("in-active")
      $(".current-patterns-container").css("display", "block")
      $(".proximal-patterns-container").css("display", "none")