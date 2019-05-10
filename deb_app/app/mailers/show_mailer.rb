require 'date'
class ShowMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.show_mailer.show_activation.subject
  #
  def show_activation(showtime)
    @greeting = "Hi Debby"
    #@showtime = showtime
    @new_time = showtime #@showtime.show_datetime.strftime("%m/%d/%Y at %I:%M%p")
    mail(to: "douganddeb3@msn.com", subject:"You've got a new booking!")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.show_mailer.show_reset.subject
  #
  def show_reset(showtime, prev_show, org)
    @org_send = org
    @altered_show2 = prev_show #showtime.show_datetime.strftime("%m/%d/%Y at %I:%M%p") 
    @greeting = "Hi Debby"
    @showtime = showtime
    if prev_show == showtime
      @new_time = "canceled"
    else  
      @new_time = @showtime.show_datetime.strftime("%m/%d/%Y at %I:%M%p")
    end  
    mail(to: "douganddeb3@msn.com", subject: "Show reset")
  end
end
