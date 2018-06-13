require 'test_helper'

class RegularDeliveryMailerTest < ActionMailer::TestCase
  test "send_monday" do
    mail = RegularDeliveryMailer.send_monday
    assert_equal "Send monday", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
