class AlbumsController < ApplicationController
  before_action :require_logged_in_user 
  before_action :set_album, only: %i[ show edit update destroy ]
  before_action :is_admin, only: %i[ destroy ]

  #GET /albums or /albums.json
  def index
    @albums = current_user.albums
    @artists = get_artists_by_id(current_user.albums)
  end

  def show_albums
    request_artist_to_api = get_artist_by_id(params[:artist])

    artist = request_artist_to_api.id
    albums_response = current_user.albums.where(artist: artist) 
    @albums = albums_response || nil
    @artist= request_artist_to_api
  end

  def confirm_delete
    @album_id = params[:album_id]
    @artist_id = params[:artist_id]
  end

  # GET /albums/new
  def new
    @album = Album.new
    @artist = get_artist_by_id(params[:artist])
  end

  # GET /albums/1/edit
  def edit
    album = Album.find_by(id: params[:id])
    @artist = get_artist_by_id(album.artist)
  end

  # POST /albums or /albums.json
  def create
    form_album = current_user.albums.build(album_params)
    @album = form_album
    @artist = get_artist_by_id(form_album.artist)

    respond_to do |format|
      if @album.save
        format.html { redirect_to show_albums_url(@artist.id, current_user.id), success: "Album was successfully created." }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1 or /albums/1.json
  def update
    form_album = current_user.albums.build(album_params)
    album = form_album
    artist = get_artist_by_id(form_album.artist)

    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to show_albums_url(artist.id, current_user.id), success: "Album was successfully updated." }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1 or /albums/1.json
  def destroy
    artist = @album.artist

    @album.destroy
    
    respond_to do |format|
      format.html { redirect_to show_albums_url(artist, current_user.id), success: "Album was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def get_list_of_artists
    artists_controller = ArtistsController.new
    artists_controller.get_list_of_artists
  end

  def get_artists_by_id(albums)
    i = 0;
    list_of_artists = []

    loop{
      list_of_artists << albums[i].artist

      if i == albums.size - 1
        break
      end

      i+=1
    }
    
    artists_controller = ArtistsController.new
    artists_controller.get_artists_by_id(list_of_artists)
  end

  def get_artist_by_id(artist_id)
    artists_controller = ArtistsController.new
    artists_controller.get_artist_by_id(artist_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = current_user.albums.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(:artist, :album_name, :year)
    end

    def is_admin
      album = Album.find_by(id: params[:id])
      artist = get_artist_by_id(album.artist)

      unless current_user.role == 2
        respond_to do |format|
          format.html { redirect_to show_albums_url(artist.id, current_user.id), danger: "You don't have access to this functionalty." }
          format.json { render json: @album.errors, status: :unprocessable_entity }
        end
      end
    end
end
