class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    Dir.entries(@path).reject {|f| File.directory? f}
  end

  def import
    files.each {|s| Song.create_from_filename(s)}
  end

end
