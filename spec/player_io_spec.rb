require "rspec"
require_relative "../lib/player_io"

RSpec.describe PlayerIO do
  describe "#print" do
    xit "prints text its given to the screen" do
      expect(subject.print("Example text")).to output("Example text").to_stdout
    end
  end

  describe "#get_option" do
  end

  describe "#set_global_option" do
  end
end
