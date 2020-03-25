class MusicLibraryController

  attr_accessor

  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets until input == "exit"
  end

  def list_songs
    sorted_songs = Song.all.sort_by{|song| song.name}.uniq
    sorted_songs.each_with_index do |song, i|
      puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    sorted_artists = Artist.all.sort_by{|artist| artist.name}.uniq
    sorted_artists.each_with_index do |artist, i|
      puts "#{i + 1}. #{artist.name}"
    end
  end

  def list_genres
    sorted_genres = Genre.all.sort_by{|genre| genre.name}.uniq
    sorted_genres.each_with_index do |genre, i|
      puts "#{i + 1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets
    artist = Artist.find_by_name(input)
    if artist
      sorted = artist.songs.sort_by{|song| song.name}
      sorted.each_with_index do |song, i|
        puts "#{i + 1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets
    genre = Genre.find_by_name(input)
    if genre
      sorted = genre.songs.sort_by{|song| song.name}
      sorted.each_with_index do |song, i|
        puts "#{i + 1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    song_input = gets.to_i
    song = sorted_songs if song_input.is_a? Integer

    puts "Playing #{song.name} by #{song.artist.name}"

  end

end
