require "rspec"
require_relative "../lib/guess_evaluator"

RSpec.describe GUessEvaluator do
  it "has a accessors for target" do
    guess_evaluator = subject
    guess_evaluator.target = "target"
    expect(guess_evaluator.target).to eql("target")
  end

  describe "#evaluate_guess" do
  end
end
