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

    it "returns -1 when the letter isn't in the word" do
      expect(@guess_evaluator.evaluate_guess("x")).to eql(-1)
    end
  end
end
