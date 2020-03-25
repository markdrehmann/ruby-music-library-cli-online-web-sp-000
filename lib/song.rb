class Song
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.genre = genre if genre
    self.artist = artist if artist
  end

  def self.create(name)
    self.new(name).tap do |s|
      s.save
    end
  end

  def self.find_by_name(name)
    @@all.find {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  def self.new_from_filename(filename)
    data = filename.chomp(".mp3").split(" - ")
    new_song = Song.find_or_create_by_name(data[1])
    new_song.artist = Artist.find_or_create_by_name(data[0])
    new_song.genre = Genre.find_or_create_by_name(data[2])
    new_song
  end

  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    song.save
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end

end
