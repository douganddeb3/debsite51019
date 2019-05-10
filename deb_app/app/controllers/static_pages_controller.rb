require 'date'
class StaticPagesController < ApplicationController
  def home
    @current_month =
      if params[:passYear]
        Date.new(params[:passYear].to_i, params[:passMonth].to_i, 1)
      else
        Date.new(Date.today.strftime("%Y").to_i, Date.today.strftime("%m").to_i, 1)
      end
      
      @microposts_display = Micropost.where.not(picture: nil)
      # redirect_back(fallback_location: root_path)
      @audio_files = Dir.entries("#{Rails.root.to_s}/app/assets/audios").select { |f| !File.directory?(f) }
      @audio_files = @audio_files.sort
      
  
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
