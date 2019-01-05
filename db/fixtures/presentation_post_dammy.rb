current_id = Presentation::Post.last.id

100.times do |i|
  Presentation::Post.seed do |s|
    s.user_id = 2
    s.title = "test"
    s.content = "<p>test</p>"
  end
  Presentation::PostPatternRelate.seed do |s|
    s.pattern_id = 113
    s.presentation_post_id = current_id + 1
  end
  current_id += 1
end