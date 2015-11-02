class ContactMailer < ActionMailer::Base
  default to: "waschat@psychomatix.de"

  def contact_us(sender_name, sender_mail, content)
    @sender_name = sender_name
    @email = sender_mail
    @content = content
    mail(from: sender_mail, subject: 'Mail über Kontaktformular')
  end
end
