class EventController < ApplicationController
  include ActionView::Helpers::UrlHelper

  include Secured
  before_action :set_profile

  def show
    @conference = Conference.first
    if session[:userinfo].present?
      if @conference.opened?
        redirect_to tracks_path
      else
        redirect_to dashboard_path
      end
    end
    @sponsor_types = @conference.sponsor_types.order(order: "ASC")
  end
  
  def logged_in_using_omniauth?
    if session[:userinfo].present?
      @current_user = session[:userinfo]
    end
  end
  
  def privacy

  end

  def coc

  end

  def sponsor_logo_class(sponsor_type)
    case sponsor_type.name
    when "Diamond", "Special Collaboration"
      "col-12 col-md-4 my-3 m-md-3"
    when "Platinum"
      "col-12 col-md-3 my-3 m-md-3"
    when "Gold", "Booth", "Mini Session", "CM", "Tool"
      "col-12 col-md-2 my-3 m-md-3"
    else
      "col-12 col-md-3 my-3 m-md-3"
    end
  end

  helper_method :sponsor_logo_class
  private

  def set_profile
    if @current_user
      @profile = Profile.find_by(email: @current_user[:info][:email])
    end
  end
end
