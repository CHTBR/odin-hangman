# Class responsible for evaluating player guesses
class GuessEvaluator
  attr_accessor :target

  def evaluate_guess(guess)
    if target.include?(guess)
      pos_arr = []
      target_tmp = target
      while target_tmp.include?(guess)
        pos_arr << target_tmp.index(guess)
        target_tmp[target_tmp.index(guess)] = "0"
      end
      pos_arr
    else
      -1
    end
  end
end
