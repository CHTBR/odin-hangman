require "rspec"
require_relative "../lib/guess_evaluator"

RSpec.describe GuessEvaluator do
  it "has a accessors for target" do
    guess_evaluator = subject
    guess_evaluator.target = "target"
    expect(guess_evaluator.target).to eql("target")
  end

  describe "#evaluate_guess" do
    before do
      @guess_evaluator = subject
      @guess_evaluator.target = "target"
    end

    xit "returns -1 when the letter isn't in the word" do
      expect(@guess_evaluator.evaluate_guess("x")).to eql(-1)
    end

    xit "returns the position of the letter in an array" do
      expect(@guess_evaluator.evaluate_guess("g")).to eql([3])
    end

    xit "returns multiple positions in the array if the letter appears multiple times" do
      expect(@guess_evaluator.evaluate_guess("t")).to eql([0, 5])
    end
  end
end
