# A class to manage message calls and variables during a single game of hangman
class GameManager
  def initialize(args)
    @file_reader = args[:file_reader]
    @guess_evaluator = args[:guess_evaluator]
  end

  def start_new_game
    list_of_words = @file_reader.list_of_words
    @guess_evaluator.target = list_of_words.shuffle.shuffle.sample
  end
end
