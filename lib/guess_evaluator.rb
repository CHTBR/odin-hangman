# Class responsible for evaluating player guesses
class GuessEvaluator
  attr_accessor :target

  def evaluate_guess(guess)
    if target.include?(guess)
      [target.index(guess)]
    else
      -1
    end
  end
end
