require 'test_helper'

class ShowMailerTest < ActionMailer::TestCase
  test "show_activation" do
    mail = ShowMailer.show_activation(@showtime)
    assert_equal "You've got a new booking!", mail.subject
    assert_equal ["douganddeb3@msn.com"], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "show_reset" do
    mail = ShowMailer.show_reset(@showtime, @showtime, 5)
    assert_equal "Show reset", mail.subject
    assert_equal ["douganddeb3@msn.com"], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
