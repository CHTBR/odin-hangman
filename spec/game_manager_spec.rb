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
    end
  end
end
