class Showtime < ApplicationRecord
  belongs_to :user
  default_scope -> { order(show_datetime: :asc) }
  attr_accessor :showtime_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: VALID_EMAIL_REGEX }
  validates :org, presence: true, length: { maximum: 50} 
  validates :town, presence: true, length: { maximum: 30 }
  validates :phone, presence: true, numericality: { only_integer: true }, length: { is: 10}
  validates :name, presence: true, length: { maximum: 30 }
  validates :street, presence: true, length: { maximum: 50 }
  validates :show_datetime, presence: true
                                    
  # Returns the hash digest of the given string.
  def Showtime.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Returns a random token.
  def Showtime.new_token
    SecureRandom.urlsafe_base64
  end
  
  def send_activation_email(brand_new) 
    ShowMailer.show_activation(brand_new).deliver_now
  end
  
  def send_reset_email(new, prev, org)
    ShowMailer.show_reset(new, prev, org).deliver_now
  end 
  
  def format_for_mailer
    
  end  
  
  
end
