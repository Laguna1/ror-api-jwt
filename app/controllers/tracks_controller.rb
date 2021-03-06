class TracksController < ApplicationController
  before_action :set_track, only: %i[show update destroy]
  before_action :authorize!

  def index
    @tracks = item.tracks.all

    render json: serializer.new(@tracks)
  end

  def show
    render json: serializer.new(@track)
  end

  def create
    @track = item.tracks.build(track_params)

    if @track.save
      render json: serializer.new(@track), status: :created
    else
      render json: @track.errors, status: :unprocessable_entity
    end
  end

  def update
    if @track.update(track_params)
      render json: serializer.new(@track)
    else
      render json: @track.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @track.destroy
  end

  def progress
    @tracks = Track.joins(
      "INNER JOIN items
        ON items.id = tracks.item_id
        AND items.user_id = #{current_user.id}
        AND tracks.name = '#{params[:name]}'
        ORDER BY routines.day ASC"
    )

    render json: serializer.new(@tracks)
  end

  private

  def set_track
    @track = item.tracks.find(params[:id])
  end

  def track_params
    params
      .require(:data)
      .require(:attributes)
      .permit(:name, :distance, :duration, :repeat) || ApplicationController::Parameters.new
  end

  def serializer
    TrackSerializer
  end

  def item
    current_user.items.find(params[:item_id])
  end
end
