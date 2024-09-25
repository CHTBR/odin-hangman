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
      allow(@file_reader).to receive(:list_of_words).and_return(["word"])
      allow(@player_io).to receive(:get_option).and_return(%w[a b c e f g h i j k])
      allow(@guess_evaluator).to receive(:evaluate_guess).and_return(-1)

      xit "requests input from the player exactly 10 times" do
        subject.start_new_game
        expect(@player_io).to have_received(:get_option).exactly(10).times
      end

    end

    context "during a game where the player only guesses right" do
    end

    context "during a 6 round game" do
    end

    context "during a game where the player saves in the 3rd round" do
    end

    context "during any game" do
    end
  end
end
