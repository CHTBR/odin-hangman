# Module for reading word source file
module FileReader
  def self.list_of_words
    File.readlines("assets/google-10000-english-no-swears.txt").map { |line| line.chomp }
  end
end
