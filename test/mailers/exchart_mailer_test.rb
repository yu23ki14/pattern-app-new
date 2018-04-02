require 'test_helper'

class ExchartMailerTest < ActionMailer::TestCase
  test "send_pdf" do
    mail = ExchartMailer.send_pdf
    assert_equal "Send pdf", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
