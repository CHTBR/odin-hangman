# A class to manage message calls and variables during a single game of hangman
class GameManager
  def initialize(args)
    @file_reader = args[:file_reader]
  end

  def start_new_game
    @file_reader.list_of_words
  end
end
