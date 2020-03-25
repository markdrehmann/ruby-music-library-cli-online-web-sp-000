class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def artists
    array = self.songs.collect do |song|
      song.artist
    end
    array.uniq
  end

  def self.create(name)
    self.new(name).tap do |s|
      s.save
    end
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
