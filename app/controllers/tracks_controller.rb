class TracksController < ApplicationController
  include Secured
  before_action :set_profile

  def index
    @conference = Conference
                  .includes(:talks)
                  .includes(sponsor_types: {sponsors: :sponsor_attachment_logo_image})
                  .order("sponsor_types.order ASC")
                  .find_by(abbr: event_name)
    if @conference.abbr != "cndt2020" && @conference.opened?
      redirect_to  "/#{params[:event]}/ui/"
    end
    @current = Video.on_air
    @tracks = Track.all

    @talks = Talk.eager_load(:talk_category, :talk_difficulty).all
    @talk_categories = TalkCategory.where(conference_id: @conference.id)
    @talk_difficulties = TalkDifficulty.where(conference_id: @conference.id)
    @booths = Booth.where(conference_id: @conference.id, published: true)
  end

  def waiting
    @conference = Conference.find_by(abbr: event_name)
    if @conference.opened?
      redirect_to tracks_path
    end

    @announcements = @conference.announcements.where(publish: true)
    @talks = Talk.eager_load(:talk_category, :talk_difficulty).all
    @talk_categories = TalkCategory.all
    @talk_difficulties = TalkDifficulty.all
    @booths = Booth.where(conference_id: @conference.id, published: true)
  end

  def reload
    ActionCable.server.broadcast("waiting_channel","aaa");
    render plain: "OK"
  end

  def blank
    @msg = params.key?(:msg) ? params[:msg] : "No content"
    render :layout => false
  end

  private
  def set_profile
    if @current_user
      @profile = Profile.find_by(email: @current_user[:info][:email], conference_id: set_conference.id)
    end
  end
end
