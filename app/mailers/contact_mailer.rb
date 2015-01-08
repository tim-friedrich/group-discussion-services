class ContactMailer < ActionMailer::Base
  default to: "friedrich.tim@googlemail.com"

  def contact_us(sender_name, sender_mail, content)
    @sender_name = sender_name
    @email = sender_mail
    @content = content
    mail(from: sender_mail, subject: 'Mail über Kontaktformular')
  end
end
