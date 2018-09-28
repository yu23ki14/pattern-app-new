$(document).on 'turbolinks:load', ->
  if $("body").hasClass("learning_styles new") || $("body").hasClass("learning_styles edit")
    if $("#learning_style_result").val() != ""
      result = JSON.parse($("#learning_style_result").val())
      if Object.keys(result).length == 40
        phase = 2
        $(".").removeClass("hide")
      if Object.keys(result).length == 74
        phase = 3
        $(".lp").removeClass("hide")
      if Object.keys(result).length == 108
        phase = 4
        $(".pp").removeClass("hide")
        $("input[type='submit']").val("結果を見る").addClass("button-primary").removeClass("button-outline")
        $(".js-next-phase").addClass("hide")
    else
      result = {}
      phase = 1
    $("form").on 'change', (e) ->
      identifier = $(this).attr("identifier")
      value = $(e.target).val()
      result[identifier] = value
      $("#learning_style_result").val(JSON.stringify(result))
      if Object.keys(result).length == 40 || Object.keys(result).length == 74 || Object.keys(result).length == 108 || Object.keys(result).length == 140
        $(".button").attr("disabled", false)
      if Object.keys(result).length == 140
        $("#learning_style_finished").val(true)
    $(".js-next-phase").on 'click', (e) ->
      phase += 1
      if phase == 2
        $(".ls-questions").addClass("hide")
        $(".cp").removeClass("hide")
      else if phase == 3
        $(".ls-questions").addClass("hide")
        $(".pp").removeClass("hide")
      else if phase == 4
        $(".ls-questions").addClass("hide")
        $(".pdp").removeClass("hide")
        $(".js-next-phase").addClass("hide")
        $("input[type='submit']").val("結果を見る").addClass("button-primary").removeClass("button-outline")
      $(window).scrollTop(0)
      $(".button").attr("disabled", "disabled")
      return false
  
  if $("body").hasClass("learning_styles show")
    
    ctx = document.getElementById("myChart").getContext("2d")
    color = "rgba(243, 158, 155, 0.5)"
    result = JSON.parse(gon.result)
    
    identifier_num = [0, 0, 0, 0, 0, 0, 0, 0]
    result_calcurated = [0, 0, 0, 0, 0, 0, 0, 0]
    identifier_range = [0, 0, 0, 0, 0, 0, 0, 0]
    data = [0, 0, 0, 0, 0, 0, 0, 0]
    
    for key, value of result
      identifier = key.slice(-1)
      identifier_num[identifier - 1] += 1
      result_calcurated[identifier - 1] += parseInt(value)
    
    console.log result_calcurated
    
    for value, index in identifier_num
      identifier_range[index] = (100/(value*2)).toFixed(3)
      
    console.log identifier_range
    
    for value, index in identifier_range
      score = (50 + value * result_calcurated[index]).toFixed(2)
      data[index] = score
      $(".js-style-" + index + " .score").text(score)
    console.log data
    
    #チャートのオプション
    options = {scale:
                display: true
                pointLabels:
                  display: true
                  fontSize: 11
                ticks:
                  stepSize: 20
                  beginAtZero: true
                  display: false
                  max: 100
                  min: 0
              legend:
                display: false
              animation: false
              }
                
    #チャート生成
    myChart = new Chart(ctx,
      type: 'radar'
      data:
        labels: ["経験", "想像", "内省", "分析", "思案", "決定", "行動", "前進"]
        datasets: [{
          data: data
          pointRadius:0
          pointHitRadius:20
          backgroundColor: color
          borderColor: color
          borderWidth: 1
        }]
      options: options)