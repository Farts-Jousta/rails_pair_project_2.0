class TracksController < ApplicationController
  before_action :set_track, only: [:show, :edit, :update, :destroy]
  helper_method :seconds_to_time

  def seconds_to_time(seconds)
    [seconds / 3600, seconds / 60 % 60, seconds % 60].map { |t| t.to_s.rjust(2,'0') }.join(':')
  end

  # GET /tracks
  # GET /tracks.json
  def index
    @tracks = Track.all
  end

  # GET /tracks/1
  # GET /tracks/1.json
  def show
    @albums = Album.joins(:tracks).where('tracks.id' => params[:id]).uniq
  end

  # GET /tracks/new
  def new
    @track = Track.new
    @album = Album.find(params[:id])
    @artist = Artist.find(@album.artist_id)
  end

  # GET /tracks/1/edit
  def edit
  end

  # POST /tracks
  # POST /tracks.json
  def create
    puts "CREATE TRACK"
    @track = Track.create(title: params[:track][:title], length: params[:track][:length])
    @album = Album.find(params[:track][:album])
    AlbumTrack.create(album_id: @album.id, track_id: @track.id)
    puts @album.title
    

    respond_to do |format|
      if @track.save
        @album.tracks << @track
        format.html { redirect_to @track, notice: 'Track was successfully created.' }
        format.json { render :show, status: :created, location: @track }
      else
        format.html { render :new }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tracks/1
  # PATCH/PUT /tracks/1.json
  def update
    respond_to do |format|
      if @track.update(track_params)
        format.html { redirect_to @track, notice: 'Track was successfully updated.' }
        format.json { render :show, status: :ok, location: @track }
      else
        format.html { render :edit }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1
  # DELETE /tracks/1.json
  def destroy
    @joins = AlbumTrack.where(track_id: @track.id)
    @joins.each do |join|
      join.destroy
    end
    puts @track.title
    @track.destroy

    respond_to do |format|
      format.html { redirect_to tracks_url, notice: 'Track was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def track_params
      params.require(:track).permit(:title, :length)
    end
end
