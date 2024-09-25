# A class to manage message calls and variables during a single game of hangman
class GameManager
  def initialize(args)
    @file_reader = args[:file_reader]
    @guess_evaluator = args[:guess_evaluator]
    @player_io = args[:player_io]
    @save_manager = args[:save_manager]
  end

  def start_new_game
    list_of_words = @file_reader.list_of_words
    @target = list_of_words.shuffle.shuffle.sample
    @guess_evaluator.target = @target
    @guess_target = Array.new(@target.size, "_")
    @player_io.set_global_option("save")
    @num_of_wrong_guesses = 0
    @num_of_correct_guesses = 0
    @guess_options = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    _game_loop
  end

  def _game_loop
    until _lost? || _won?
      guess = @player_io.get_option({ message: "Choose a letter:",
                                      options: @guess_options })
      if guess == "save"
        @save_manager.save_game(self)
        return
      end
      @guess_options -= [guess]
      evaluation = @guess_evaluator.evaluate_guess(guess)

      if evaluation == -1
        @num_of_wrong_guesses += 1
        @player_io.print("Sadly, your guess was incorrect. Try again.")
        @player_io.print("You have #{10 - @num_of_wrong_guesses} guesses left")
      else
        @num_of_correct_guesses += evaluation.size
        @player_io.print("Yay, you guessed correctly.")
        evaluation.each { |position| @guess_target[position] = guess }
      end
      @player_io.print(@guess_target.join(" "))
    end

    if _lost?
      @player_io.print("Regretably, you didn't manage to win.")
    else
      @player_io.print("Congratulations, you won!")
    end
  end

  def _lost?
    @num_of_wrong_guesses == 10
  end

  def _won?
    @num_of_correct_guesses == @target.size
  end
end
