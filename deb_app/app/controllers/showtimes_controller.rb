require 'date'
require 'active_support/core_ext/numeric/time.rb'


class ShowtimesController < ApplicationController
  before_action :set_showtime, only: [:show, :edit, :update, :destroy]

  # GET /showtimes
  # GET /showtimes.json
  def index
    if !current_user 
      redirect_to root_url #failed test so changed this
    elsif current_user && !current_user.admin?
      @showtimes = Showtime.where(email: current_user.email)
    elsif current_user.admin?
      @showtimes = Showtime.all
    end
  end
  # GET /showtimes/1
  # GET /showtimes/1.json
  def show
    @showtime = Showtime.find(params[:id])
    @showtime.show_datetime_end = DateTime.new(@showtime.show_datetime.strftime("%Y").to_i, @showtime.show_datetime.strftime("%m").to_i, @showtime.show_datetime.strftime("%d").to_i, @showtime.show_datetime.strftime("%H").to_i + 1, @showtime.show_datetime.strftime("%M").to_i )
    @times = avail_times(@showtime)
  end

  # This method called from showtimes_calendar  GET /showtimes/new
  def new
    @showtime = Showtime.new(showtime_params)
    @day = @showtime.day
    # @showtime.month = params[:month_pass]
    # @showtime.day = params[:day_pass]
    # @showtime.year = params[:year_pass]
    @showtime.show_datetime = DateTime.new(@showtime.year.to_i, @showtime.month.to_i, @showtime.day.to_i, 0, 0)
    
    @times = avail_times(@showtime)
    @times_display = avail_times_to_ampm(@times)
    @hours_avail_on_view = @times_display.zip(@times)
    if current_user
      temp_showtime = Showtime.where(email: current_user.email).last
      if temp_showtime
        @showtime.org = temp_showtime.org
        @showtime.town = temp_showtime.town
        @showtime.street = temp_showtime.street
        @showtime.name = temp_showtime.name
        @showtime.email = temp_showtime.email
        @showtime.phone = temp_showtime.phone
      end
    end 
  end

  # GET /showtimes/1/edit
  def edit
    @times = avail_times(@showtime)
    @times_display = avail_times_to_ampm(@times)
    @hours_avail_on_view = @times_display.zip(@times) 
    @showtime.show_datetime_end = DateTime.new(@showtime.show_datetime.strftime("%Y").to_i, @showtime.show_datetime.strftime("%m").to_i, @showtime.show_datetime.strftime("%d").to_i, @showtime.show_datetime.strftime("%H").to_i + 1, @showtime.show_datetime.strftime("%M").to_i)
      
  end

  # POST /showtimes
  # POST /showtimes.json
  
  def create
    if current_user
      @showtime = current_user.showtimes.new(showtime_params)
    else
      user = User.find_by(name: "non login")
      @showtime = user.showtimes.new(showtime_params)
    end 
    @showtime.update_attribute(:show_datetime, @showtime.show_datetime.change(hour: @showtime.time, min: @showtime.duration))
    @showtime.show_datetime_end = DateTime.new(@showtime.show_datetime.strftime("%Y").to_i, @showtime.show_datetime.strftime("%m").to_i, @showtime.show_datetime.strftime("%d").to_i, @showtime.show_datetime.strftime("%H").to_i + 1, @showtime.show_datetime.strftime("%M").to_i)
    @current_day = @showtime.show_datetime.strftime("%d").to_i
    @times = avail_times(@showtime)
    @times_display = avail_times_to_ampm(@times)
    @hours_avail_on_view = @times_display.zip(@times)
    if available_time?(@showtime)
      respond_to do |format|
        if @showtime.save
          @showtime.send_activation_email(@showtime)
          flash[:success] = "Showtime was successfully created" 
          format.html { redirect_to @showtime } #, notice: 'Showtime was successfully created.'
          format.json { render :show, status: :created, location: @showtime }
        else
          format.html { render :new }
          format.json { render json: @showtime.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        flash[:warning] = "Showtime was not successfully created" 
        format.html { render :new } #, notice: 'Showtime was not successfully created.'
        format.json { render json: @showtime.errors, status: :unprocessable_entity }
      end  
    end  
  end

  # PATCH/PUT /showtimes/1
  # PATCH/PUT /showtimes/1.json
  def update
    @org_send = @showtime.org
    # @showtime = Showtime.find(params[:id])
    @altered_show_create = DateTime.new(@showtime.show_datetime.strftime("%Y").to_i, @showtime.show_datetime.strftime("%m").to_i, @showtime.show_datetime.strftime("%d").to_i, @showtime.show_datetime.strftime("%H").to_i , @showtime.show_datetime.strftime("%M").to_i)
    @altered_show = @altered_show_create.strftime("%m/%d/%Y at %I:%M%p")
    @current_day = @showtime.show_datetime.strftime("%d").to_i
    @showtime.update_attribute(:day, @current_day)
    @times = avail_times(@showtime) 
    @times_display = avail_times_to_ampm(@times)
    @hours_avail_on_view = @times_display.zip(@times)
    @showtime.update(showtime_params)
    @showtime.update_attribute(:show_datetime, @showtime.show_datetime.change(hour: @showtime.time, min: @showtime.duration))
    @current_day = @showtime.show_datetime.strftime("%d").to_i
    
    if available_time?(@showtime)
      respond_to do |format|
        if @showtime.save #update(showtime_params)
          @showtime.update_attribute(:show_datetime, @showtime.show_datetime.change(hour: @showtime.time, min: @showtime.duration))
          @showtime.show_datetime_end = DateTime.new(@showtime.show_datetime.strftime("%Y").to_i, @showtime.show_datetime.strftime("%m").to_i, @showtime.show_datetime.strftime("%d").to_i, @showtime.show_datetime.strftime("%H").to_i + 1, @showtime.show_datetime.strftime("%M").to_i)
          @times = avail_times(@showtime)
          @showtime.send_reset_email(@showtime, @altered_show_create, @org_send)
          flash[:success] = "Showtime was successfully updated" 
          format.html { redirect_to @showtime} #, notice: 'Showtime was successfully updated.' }
          format.json { render :show, status: :ok, location: @showtime }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @showtime.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        @times = avail_times(@showtime) 
        flash[:success] = "Showtime was not successfully created" 
        format.html { render :new } #, notice: 'Showtime not was successfully created.'
        format.json { render json: @showtime.errors, status: :unprocessable_entity }
      end 
    end  
  end

  # DELETE /showtimes/1
  # DELETE /showtimes/1.json
  def destroy
    @org_send = @showtime.org
    @showtime.send_reset_email(@showtime, @showtime, @org_send)
    @showtime.destroy
    respond_to do |format|
      format.html { redirect_to showtimes_url, notice: 'Showtime was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def avail_times(show)
     
      @today_shows = Showtime.where(day: show.day)
      times_avail_temp = []
      times_used = []
      if @today_shows != nil
        @today_shows.each do |i|
            if show.id != i.id         #consider the time that the user just selected as still available
              times_used << i.show_datetime.strftime("%H").to_i
              times_used << i.show_datetime.strftime("%H").to_i + 1
              times_used << i.show_datetime.strftime("%H").to_i + 2
            end  
        end
        (9..16).each do |j|
          if !times_used.include?(j) && !times_used.include?(j + 1) && !times_used.include?(j + 2) 
            times_avail_temp << j
          end  
        end  
      else
        times_avail_temp = [ 9,10,11,12,13,14,15,16]
      end  
      return times_avail_temp
  end
  
  def available_time?(shown)
        times_avail2 = avail_times(shown)
        if times_avail2.include?(shown.show_datetime.strftime("%H").to_i)
          return true
        else
          return false
        end
  end
  
  def avail_times_to_ampm(t_array)
    ampm_avail = []
    t_array.each do |k|
      if k < 12
        ampm_avail << "#{k}AM "
      elsif k == 12
        ampm_avail << "12PM "
      else
        ampm_avail << "#{k%12}PM "
      end 
    end
    return ampm_avail
  end   

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_showtime
        @showtime = Showtime.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def showtime_params
        params.require(:showtime).permit(:year, :org, :town, :street, :name, :email, :phone, :month, :day, :time, :duration, :show_datetime, :radio_time, :show_datetime_end, :been_update, :pic, :content)
      end
      
      
    
    
end