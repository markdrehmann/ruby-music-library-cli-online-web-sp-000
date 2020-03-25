class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def genres
    array = self.songs.collect do |song|
      song.genre
    end
    array.uniq
  end

  def self.create(name)
    self.new(name).tap do |s|
      s.save
    end
  end

  def add_song(song)
    @songs << song unless @songs.include?(song)
    song.artist = self if song.artist == nil
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
