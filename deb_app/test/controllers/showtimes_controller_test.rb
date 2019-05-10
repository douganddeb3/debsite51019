require 'test_helper'

class ShowtimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @showtime = showtimes(:one)
    @showtime2 = showtimes(:two)
  end

  test "should get index when logged in" do
    log_in_as(users(:archer))
    get showtimes_url
    assert_response :success
  end
  
  test "should get root when not logged in" do
    get showtimes_url
    assert_redirected_to root_url  #showtime_url(@showtime)
  end

  test "should get new" do
    get new_showtime_url(showtime: { year: "2019", month: "03", day: "26"})
    assert_response :success
  end

  test "should create showtime" do
    assert_difference('Showtime.count') do
      post showtimes_url  params: { showtime: { been_update: @showtime.been_update, content: @showtime.content, day: @showtime.day, duration: @showtime.duration, email: @showtime.email, month: @showtime.month, name: @showtime.name, org: @showtime.org, phone: @showtime.phone, pic: @showtime.pic, radio_time: @showtime.radio_time, show_datetime: @showtime.show_datetime, show_datetime_end: @showtime.show_datetime_end, street: @showtime.street, time: @showtime.time, town: @showtime.town } }
    end
    # All similar methods to test redirect:
    assert_match /http:\/\/www.example.com\/showtimes/, @response.redirect_url  #using regex
    assert_match %r{http://www.example.com/showtimes} , @response.redirect_url  #also using regex
    assert_redirected_to @response.redirect_url
    assert_redirected_to CGI.unescape(showtime_url("980190963")) #found this # with pry using request.path and request.fullpath
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "should show showtime" do
    get showtime_url(@showtime)
    assert_response :success
  end

  test "should get edit" do
    get edit_showtime_url(@showtime)
    assert_response :success
  end

  test "should update showtime" do
    log_in_as(users(:archer))
    patch showtime_url(@showtime), params: { showtime: { been_update: @showtime.been_update, content: @showtime.content, day: @showtime.day, duration: @showtime.duration, email: @showtime.email, month: @showtime.month, name: @showtime.name, org: @showtime.org, phone: @showtime.phone, pic: @showtime.pic, radio_time: @showtime.radio_time, show_datetime: @showtime.show_datetime, show_datetime_end: @showtime.show_datetime_end, street: @showtime.street, time: @showtime.time, town: @showtime.town } }
    #assert_redirected_to showtime_url(@showtime)
    assert_match %r{http://www.example.com/showtimes} , @response.redirect_url 
  end

  test "should destroy showtime" do
    assert_difference('Showtime.count', -1) do
      delete showtime_url(@showtime)
    end

    assert_redirected_to showtimes_url
  end
end
