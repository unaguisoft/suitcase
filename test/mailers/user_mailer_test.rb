require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  setup do
    @user = User.find_by(name: 'Ross')
    @user.generate_reset_password_token!
  end

  test "reset_password_email" do
    mail = UserMailer.reset_password_email(@user).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    assert_equal 'Your password has been reset', mail.subject
    assert_equal [@user.email], mail.to
    assert_equal ["info@suitcase.com"], mail.from
    assert_match "You have requested to reset your password", mail.body.encoded
  end

end

