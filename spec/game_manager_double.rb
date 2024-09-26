require_relative "../lib/game_manager"

# role class for converting to json
class GameManagerDouble < GameManager
  attr_reader :json_representation

  def initialize # rubocop:disable Lint/MissingSuper
    @json_representation = "{\"target\":\"target\",\"guess_target\":[\"t\",\"_\",\"r\",\"_\",\"_\",\"t\"],\"num_of_wrong_guesses\":1,\"num_of_correct_guesses\":3,\"guess_options\":[\"a\",\"b\",\"c\",\"d\",\"e\",\"f\",\"g\",\"h\",\"i\",\"j\",\"k\",\"l\",\"m\",\"n\",\"p\",\"q\",\"s\",\"u\",\"v\",\"w\",\"x\",\"y\",\"z\"]}"
    @target = "target"
    @guess_target = %w[t _ r _ _ t]
    @num_of_wrong_guesses = 1
    @num_of_correct_guesses = 3
    @guess_options = %w[a b c d e f g h i j k l m n p q s u v w x y z]
  end

  def _initialize_variables(args)
    print "initialized variables with #{args["target"]}, #{args["guess_target"].join(' ')}, #{args["num_of_wrong_guesses"]}, #{args["num_of_correct_guesses"]}, #{args["guess_options"].join(' ')}"
  end
end
