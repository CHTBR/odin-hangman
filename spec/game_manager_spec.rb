require "rspec"
require_relative "../lib/game_manager"

RSpec.describe GameManager do
  describe "#start_new_game" do
    context "before initializing the game loop" do
      xit "tries to get a list of possible words from the file reader" do
        expect(@file_reader).to receive(:list_of_words)
        subject.start_new_game
      end

      xit "selects a word from the list and gives it to the guess evaluator" do
        word_list = %w[this is a list of random words]
        allow(@file_reader).to receive(:list_of_words).and_return(word_list)
        expect(@guess_evaluator).to receive(:target=)
        subject.start_new_game
      end

      xit "selects a different word from the list each time" do
        word_list = %w[this is a list of random words]
        allow(@file_reader).to receive(:list_of_words).and_return(word_list)

        subject.start_new_game
        target1 = @guess_evaluator.target
        subject.start_new_game
        target2 = @guess_evaluator.target

        expect(target1).to_not eql(target2)
      end
    end

    context "during a game where the player only guesses wrong" do
      number_of_guesses = 10
      allow(@file_reader).to receive(:list_of_words).and_return(["word"])
      allow(@player_io).to receive(:get_option).and_return(%w[a b c e f g h i j k])
      allow(@guess_evaluator).to receive(:evaluate_guess).and_return(-1)

      xit "requests input from the player exactly 10 times" do
        subject.start_new_game
        expect(@player_io).to have_received(:get_option).exactly(number_of_guesses).times
      end

      xit "asks to evaluate player guess exactly 10 times" do
        subject.start_new_game
        expect(@guess_evaluator).to have_recieved(:evaluate_guess).exactly(number_of_guesses).times
      end

      xit "sends a message to the player stating their guess was incorrect" do
        incorrect_guess_message = "Sadly, your guess was incorrect. Try again."
        expect(@player_io).to receive(:print).with(incorrect_guess_message).exactly(number_of_guesses).times
        subject.start_new_game
      end

      xit "sends a message to the player stating how many guesses they have left" do
        max_number_of_wrong_guesses = 10
        guesses_left_message = ["You have  ", " guesses left"]
        number_of_guesses.times do |num|
          expect(@player_io).to receive(:print).with(guesses_left_message[0] + (max_number_of_wrong_guesses - num) + guesses_left_message[1])
        end
        subject.sart_new_game
      end
    end

    context "during a game where the player only guesses right" do
      number_of_guesses = 4
      guesses_array = %w[w o r d]
      allow(@file_reader).to receive(:list_of_words).and_return(["word"])
      allow(@player_io).to receive(:get_option).and_return(guesses_array)
      allow(@guess_evaluator).to receive(:evaluate_guess).and_return([1, 2, 3, 4])

      xit "requests input from the player exactly 4 times" do
        subject.start_new_game
        expect(@player_io).to have_received(:get_option).exactly(number_of_guesses).times
      end

      xit "asks to evaluate player guess exactly 4 times" do
        subject.start_new_game
        expect(@guess_evaluator).to have_recieved(:evaluate_guess).exactly(number_of_guesses).times
      end

      xit "sends a message to the player stating their guess was correct" do
        incorrect_guess_message = "Yay, you guessed correctly."
        expect(@player_io).to receive(:print).with(incorrect_guess_message).exactly(number_of_guesses).times
        subject.start_new_game
      end

      xit "sends a message to the player with the guessed latters filled out in the target word" do
        blank_guess = "_ _ _ _"
        expect(@player_io).to receive(:print).with(blank_guess)
        guesses_array.each do |guess|
          blank_guess = blank_guess.sub("_", guess)
          expect(@player_io).to receive(:print).with(blank_guess)
        end
        subject.start_new_game
      end
    end

    context "during a 6 round game" do
    end

    context "during a game where the player saves in the 3rd round" do
    end

    context "during any game" do
      guesses_array = %w[a b c e f g h i j k]
      allow(@file_reader).to receive(:list_of_words).and_return(["word"])
      allow(@player_io).to receive(:get_option).and_return(guesses_array)

      xit "removes a letter from the options array every time it's guessed" do
        input_message = "Choose a letter:"
        allow(@guess_evaluator).to receive(:evaluate_guess).and_return(-1)
        letters_array = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
        subject.start_new_game
        expect(@player).to have_recieved(:get_option).with({ message: input_message, options: letters_array })
        guesses_array.each do |guess|
          letters_array -= [guess]
          expect(@player).to have_recieved(:get_option).with({ message: input_message, options: letters_array })
        end
      end
    end
  end
end
