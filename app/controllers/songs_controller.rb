class SongController < ApplicationController

  get '/songs' do
    @songs = Song.all

    erb :'songs/index'
  end

  get '/songs/new' do
    @genres = Genre.all

    erb :'/songs/new'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all

    erb :'/songs/edit'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])

    erb :'/songs/show'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])

    if Artist.find_by(name: params[:artist_name])
      @artist = Artist.find_by(name: params[:artist_name])
    else
      @artist = Artist.create(name: params[:artist_name])
    end

    params[:genres].each do |genre_name|
      @genre = Genre.find_by(name: genre_name)
      @song.genres << @genre
      @genre.songs << @song
    end

    @song.update(name: params[:song_name], artist: @artist)

    flash[:message] = "Successfully updated song."

    redirect "/songs/#{@song.slug}"
  end

  post '/songs' do
    @song = Song.create(name: params[:name])

    if Artist.find_by(name: params[:artist_name])
      @artist = Artist.find_by(name: params[:artist_name])
    else
      @artist = Artist.create(name: params[:artist_name])
    end
    @song.artist = @artist
    @artist.songs << @song


    params[:genres].each do |genre|
      @genre = Genre.create(name: genre)
      @song.genres << @genre
      @genre.songs << @song
    end

    flash[:message] = "Successfully created song."

    redirect "/songs/#{@song.slug}"
  end
end
