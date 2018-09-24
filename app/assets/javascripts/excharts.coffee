$(document).on 'turbolinks:load', ->
  if $("body").hasClass("index")
    $(document).on 'click', '.js-trigger-modal-select-mode',->
      $("#select_mode").modal()
      return false
  if $("body").hasClass("excharts new")
    
    #ベース
    setCardheight = ->
      card_height = $(".js-swiping-card").height()
      $(".card-stack").css("height", card_height + 15)
    setTimeout ->
      setCardheight()
    , 50
    
    #フリックカード
    if $("#exchart_data1").val() != ""
      progress = Object.keys(JSON.parse($("#exchart_data1").val())).length
    else
      progress = 0
    
    allcard = $(".card").length - progress
    allcards = $(".card").length
    single_span = ($(".progressbar-outline").width() - 24) / allcards
    max_bar_width = $(".progressbar-outline").width() - 2
    bar_width = $(".js-trigger-bar").width()
    element = document.getElementById('card' + allcard)
    if $("#exchart_data1").val() != ""
      new_data1 = JSON.parse($("#exchart_data1").val())
      new_data2 = JSON.parse($("#exchart_data2").val())
    else
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
        if pattern_no != undefined
          new_data1[pattern_no] = 1
          $("#exchart_data1").val(JSON.stringify(new_data1))
          new_data2[pattern_no] = 1
          $("#exchart_data2").val(JSON.stringify(new_data2))
      else if direction == "left"
        $("#card" + allcard).css('transform', 'translate(-105vw, 0) rotate(5deg)')
        pattern_no = $("#card" + allcard).attr('pattern_no')
        if pattern_no != undefined
          new_data1[pattern_no] = 0
          $("#exchart_data1").val(JSON.stringify(new_data1))
          new_data2[pattern_no] = 0
          $("#exchart_data2").val(JSON.stringify(new_data2))
      else if direction == "up"
        $("#card" + allcard).css('transform', 'translate(0, -155vw) rotate(-5deg)')
        pattern_no = $("#card" + allcard).attr('pattern_no')
        if pattern_no != undefined
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
        $(".flick-controller").css("display", "none")
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
        
    $(document).on 'click', '.flick-button.left',->
      roop("left")
      return false
    $(document).on 'click', '.flick-button.right',->
      roop("right")
      return false
    $(document).on 'click', '.flick-button.up',->
      roop("up")
      return false
      
    base()
    
    #1つ戻る
    reverse = ->
      if allcard < allcards
        allcard += 1
        $("#card" + allcard).css('transform', 'translate(0, 0) rotate(0)')
        bar_width = bar_width - single_span
        $(".js-trigger-bar").css("width", bar_width)
    $(document).on 'click', '.flick-button.reverse',->
      reverse()
      
    setTimeout ->
      window.onpopstate = ->
        history.pushState()
    , 1000
    
  if $("body").hasClass("excharts show") || $("body").hasClass("excharts compare_result")
    if $("body").hasClass("excharts show")
      data1_color = "rgba(243, 158, 155, 0.7)"
      data2_color = "rgba(243, 158, 155, 0.5)"
    else if $("body").hasClass("excharts compare_result")
      data1_color = "rgba(255, 209, 0, .85)"
      data2_color = "rgba(255, 209, 0, 0.35)"
    
    path_id = $(".title").attr("path_id")
    patterns = gon.patterns
    ctx = document.getElementById("myChart").getContext("2d")
    
    #データの成形
    original_data1 = JSON.parse(gon.data1)
    original_data2 = JSON.parse(gon.data2)
    data_length = Object.keys(original_data1).length - 1
    
    if $("body").hasClass("excharts compare_result")
      cleaned_data = {}
      for i in [0..data_length] by 1
        if original_data2[i] == 0 && original_data1[i] == 1
          cleaned_data[i] = 1
        else if original_data2[i] == 1
          cleaned_data[i] = 1
        else
          cleaned_data[i] = 0
      original_data2 = cleaned_data
    
    data1 = []
    data2 = []
    
    console.log original_data1
    console.log original_data2
    
    
    for i in [1..data_length] by 3
      d1 = original_data1[i] + original_data1[i+1] + original_data1[i+2]
      data1.push(d1)
      d2 = original_data2[i] + original_data2[i+1] + original_data2[i+2]
      data2.push(d2)
    
    
    console.log data1
    console.log data2
      
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
                  max: 3
                  min: 0
              legend:
                display: false
              animation: false
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
          backgroundColor: data1_color
          borderColor: data1_color
          borderWidth: 1
        },{
          data: data2
          pointRadius:0
          pointHitRadius:20
          backgroundColor: data2_color
          borderColor: data2_color
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
        if gon.locale == "ja"
          for i in [1..3]
            pattern = patterns[(firstPoint.index * 3) + i]
            $(".js-place-pattern-list").append('<a href="/patterns/' + pattern.language_id + '/' + pattern.pattern_no + '?path_id=' + path_id + '"><p class="row-space-2">・' + pattern.pattern_name_ja + '</p></a>')
        else
          for i in [1..3]
            pattern = patterns[(firstPoint.index * 3) + i]
            $(".js-place-pattern-list").append('<a href="/patterns/' + pattern.language_id + '/' + pattern.pattern_no + '?path_id=' + path_id + '"><p class="row-space-2">・' + pattern.pattern_name_en + '</p></a>')
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
      
    $(document).on 'click', '.js-trigger-pattern-detail', ->
      $.ajax(
        type: 'GET',
        url: '/excharts/' + $(this).attr('language_id') + '/'+$(this).attr('pattern_no') + '/detail'
      ).done ->
        $('#pattern_detail').modal()
        href = $('.js-link-to-pattern').attr("href")
        href = href + "?path_id=" + path_id
        $('#pattern_detail a').attr("href", href)
    
    $('.js-trigger-add-practice').click ->
      language_id = $(this).attr("language_id")
      pattern_no = $(this).attr("pattern_no")
      $("#practice_language_id").val(language_id)
      $("#practice_pattern_no").val(pattern_no)
      $('#add-practice').modal()
      
      
    #canvas画像化
    
    
    Base64toBlob = (base64) ->
      tmp = base64.split(',')
      data = atob(tmp[1])
      mime = tmp[0].split(':')[1].split(';')[0]
      buf = new Uint8Array(data.length)
      i = 0
      while i < data.length
        buf[i] = data.charCodeAt(i)
        i++
      blob = new Blob([ buf ], type: mime)
      blob
      
    imageType = 'image/png'
    fileName = 'sample.png'
    canvas = document.getElementById('myChart')
    base64 = canvas.toDataURL(imageType)
    blob = Base64toBlob(base64)
    
    $(".chart-image").val(base64)
    
  if $("body").hasClass("excharts compare")
    array = []
    changed = false
    $('.js-set-compare-result').click (e)->
      e.preventDefault()
      if $(this).hasClass("selected")
        id = $(this).attr("chart_id")
        if $("#compare_chart_id_1").val() == id
          $("#compare_chart_id_1").val("")
        else if $("#compare_chart_id_2").val() == id
          $("#compare_chart_id_2").val("")
        $(this).removeClass("selected")
      else
        id = $(this).attr("chart_id")
        $(this).addClass("selected")
        if $("#compare_chart_id_1").val() == ""
          $("#compare_chart_id_1").val(id)
        else if $("#compare_chart_id_2").val() != "" && changed == false
          pre = $("#compare_chart_id_1").val()
          $("#card"+pre).removeClass("selected")
          $("#compare_chart_id_1").val(id)
          changed = true
        else if $("#compare_chart_id_2").val() != "" && changed == true
          pre = $("#compare_chart_id_2").val()
          $("#card"+pre).removeClass("selected")
          $("#compare_chart_id_2").val(id)
          changed = false
        else
          $("#compare_chart_id_2").val(id)
      
      if $("#compare_chart_id_1").val() != "" && $("#compare_chart_id_2").val() != ""
        $(".js-compare-submit").show()
      else
        $(".js-compare-submit").hide()
        
    $('.js-compare-submit').click (e)->
      e.preventDefault()
      
      id_1 = $("#compare_chart_id_1").val()
      id_2 = $("#compare_chart_id_2").val()
      
      location.href = "compare/result?chart_id_1=" + id_1 + "&chart_id_2=" + id_2