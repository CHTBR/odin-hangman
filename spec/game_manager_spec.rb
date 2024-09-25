require "rspec"
require_relative "../lib/game_manager"

RSpec.describe GameManager do # rubocop:disable Metrics/BlockLength
  describe "#start_new_game" do # rubocop:disable Metrics/BlockLength
    let(:subject) { GameManager.new({ player_io: @player_io, file_reader: @file_reader, guess_evaluator: @guess_evaluator, save_manager: @save_manager }) }
    before do
      @player_io = double("PlayerIO", print: nil, get_option: nil, set_global_option: nil)
      @file_reader = double("FileReader", list_of_words: [""])
      @guess_evaluator = double("GuessEvaluator", :target= => nil, target: nil, evaluate_guess: [1])
      @save_manager = double("SaveManager", save_game: nil)
    end

    context "before initializing the game loop" do
      it "tries to get a list of possible words from the file reader" do
        expect(@file_reader).to receive(:list_of_words)
        subject.start_new_game
      end

      it "selects a word from the list and gives it to the guess evaluator" do
        word_list = %w[this is a list of random words]
        allow(@file_reader).to receive(:list_of_words).and_return(word_list)
        expect(@guess_evaluator).to receive(:target=)
        subject.start_new_game
      end

      it "sets \"save\" as a global option for player io" do
        expect(@player_io).to receive(:set_global_option).with("save")
        subject.start_new_game
      end
    end

    context "during any game" do
      it "removes a letter from the options array every time it's guessed" do
        guesses_array = %w[a b c e f g h i j]
        input_message = "Choose a letter:"
        letters_array = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
        allow(@file_reader).to receive(:list_of_words).and_return(["word"])
        allow(@player_io).to receive(:get_option).and_return("a", "b", "c", "e", "f", "g", "h", "i", "j")
        allow(@guess_evaluator).to receive(:evaluate_guess).and_return(-1)

        expect(@player_io).to receive(:get_option).with({ message: input_message, options: letters_array })
        guesses_array.each do |guess|
          letters_array -= [guess]
          expect(@player_io).to receive(:get_option).with({ message: input_message, options: letters_array })
        end
        subject.start_new_game
      end
    end

    context "during a game where the player only guesses wrong" do # rubocop:disable Metrics/BlockLength
      number_of_guesses = 10

      before do
        allow(@file_reader).to receive(:list_of_words).and_return(["word"])
        allow(@player_io).to receive(:get_option).and_return("a", "b", "c", "e", "f", "g", "h", "i", "j", "k")
        allow(@guess_evaluator).to receive(:evaluate_guess).and_return(-1)
      end

      it "requests input from the player exactly 10 times" do
        subject.start_new_game
        expect(@player_io).to have_received(:get_option).exactly(number_of_guesses).times
      end

      it "asks to evaluate player guess exactly 10 times" do
        subject.start_new_game
        expect(@guess_evaluator).to have_received(:evaluate_guess).exactly(number_of_guesses).times
      end

      it "sends a message to the player stating their guess was incorrect" do
        incorrect_guess_message = "Sadly, your guess was incorrect. Try again."
        expect(@player_io).to receive(:print).with(incorrect_guess_message).exactly(number_of_guesses).times
        subject.start_new_game
      end

      it "sends a message to the player stating how many guesses they have left" do
        max_number_of_wrong_guesses = 9 # -1 to max number
        guesses_left_message = ["You have ", " guesses left"]
        number_of_guesses.times do |num|
          expect(@player_io).to receive(:print).with(guesses_left_message[0] + (max_number_of_wrong_guesses - num).to_s + guesses_left_message[1])
        end
        subject.start_new_game
      end

      it "sends a message to the player saying they lost" do
        losing_message = "Regretably, you didn't manage to win."
        expect(@player_io).to receive(:print).with(losing_message)
        subject.start_new_game
      end
    end

    context "during a game where the player only guesses right" do # rubocop:disable Metrics/BlockLength
      number_of_guesses = 4
      guesses_array = %w[w o r d]

      before do
        allow(@file_reader).to receive(:list_of_words).and_return(["word"])
        allow(@player_io).to receive(:get_option).and_return("w", "o", "r", "d")
        allow(@guess_evaluator).to receive(:evaluate_guess).and_return([0], [1], [2], [3])
      end

      it "requests input from the player exactly 4 times" do
        subject.start_new_game
        expect(@player_io).to have_received(:get_option).exactly(number_of_guesses).times
      end

      it "asks to evaluate player guess exactly 4 times" do
        subject.start_new_game
        expect(@guess_evaluator).to have_received(:evaluate_guess).exactly(number_of_guesses).times
      end

      it "sends a message to the player stating their guess was correct" do
        incorrect_guess_message = "Yay, you guessed correctly."
        expect(@player_io).to receive(:print).with(incorrect_guess_message).exactly(number_of_guesses).times
        subject.start_new_game
      end

      # This is actualy supposed to happen every turn, I'm just too lazy to put it in the cirrect context with all its variables
      it "sends a message to the player with the guessed latters filled out in the target word" do
        blank_guess = "_ _ _ _"
        guesses_array.each do |guess|
          blank_guess = blank_guess.sub("_", guess)
          expect(@player_io).to receive(:print).with(blank_guess)
        end
        subject.start_new_game
      end

      it "sends a message to the player congratulating them on winning" do
        congrats_message = "Congratulations, you won!"
        expect(@player_io).to receive(:print).with(congrats_message)
        subject.start_new_game
      end
    end

    context "during a 6 round game" do
      number_of_guesses = 6
      guesses_array = %w[w l o s r d]

      before do
        allow(@file_reader).to receive(:list_of_words).and_return(["word"])
        allow(@player_io).to receive(:get_option).and_return(guesses_array)
        allow(@guess_evaluator).to receive(:evaluate_guess).and_return([1], -1, [2], -1, [3], [4])
      end

      it "requests input from the player exactly 6 times" do
        subject.start_new_game
        expect(@player_io).to have_received(:get_option).exactly(number_of_guesses).times
      end

      it "asks to evaluate player guess exactly 6 times" do
        subject.start_new_game
        expect(@guess_evaluator).to have_received(:evaluate_guess).exactly(number_of_guesses).times
      end
    end

    context "during a game where the player saves" do
      it "sends a message to the save manager" do
        allow(@file_reader).to receive(:list_of_words).and_return(["word"])
        allow(@player_io).to receive(:get_option).and_return("l", "o", "save")
        allow(@guess_evaluator).to receive(:evaluate_guess).and_return(-1, [2])

        expect(@save_manager).to receive(:save_game)
        subject.start_new_game
      end
    end
  end
end
