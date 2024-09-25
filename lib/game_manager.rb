# A class to manage message calls and variables during a single game of hangman
class GameManager
  def initialize(args)
    @file_reader = args[:file_reader]
    @guess_evaluator = args[:guess_evaluator]
    @player_io = args[:player_io]
  end

  def start_new_game
    list_of_words = @file_reader.list_of_words
    @guess_evaluator.target = list_of_words.shuffle.shuffle.sample
    @player_io.set_global_option("save")
    _game_loop
  end

  def _game_loop
    guess_options = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    10.times do
      guess = @player_io.get_option({ message: "Choose a letter:",
                                      options: guess_options })
      guess_options -= [guess]
      @guess_evaluator.evaluate_guess(guess)
    end
  end
end
