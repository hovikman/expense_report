require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "status_changed" do
    mail = Notifier.status_changed
    assert_equal "Status changed", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "became_owner" do
    mail = Notifier.became_owner
    assert_equal "Became owner", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
