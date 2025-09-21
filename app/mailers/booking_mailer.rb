class BookingMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.new_booking.subject
  #
  def new_booking(booking)
    @greeting = "Hi"
    @booking = booking
    @property = booking.property

    mail to: booking.email, subject: "BOOKING CONFIRMATION - #{@property.name}"
  end

  def new_booking_admin(booking)
    @booking = booking
    @property = booking.property

    mail to: AdminConfig.instance.contact_email, subject: "New Booking Received - #{@property.name}"
  end

  def contact_email(email, message, subject)
    @email = email
    @message = message
    @subject = subject
    mail to: AdminConfig.instance.contact_email, subject: "Contact Form Submission"
  end

  def contact_confirmation(email, message, subject)
    @email = email
    @message = message
    @subject = subject
    mail to: email, subject: "Thank you for contacting us - Maldives Beach Vacation"
  end
end
