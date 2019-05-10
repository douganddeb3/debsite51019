# Preview all emails at http://localhost:3000/rails/mailers/show_mailer
class ShowMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/show_mailer/show_activation
  def show_activation
    ShowMailer.show_activation(self).deliver_now
  end

  # Preview this email at http://localhost:3000/rails/mailers/show_mailer/show_reset
  def show_reset
    ShowMailer.show_reset
  end

end
