class TestMailer < ApplicationMailer
  def test_email(to_email)
    mail(
      to: to_email,
      subject: "Test Email - #{Time.current}",
      body: "This is a test email sent at #{Time.current} to verify SMTP configuration."
    )
  end
end

