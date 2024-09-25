require "rspec"
require_relative "../lib/player_io"

RSpec.describe PlayerIO do
  describe "#print" do
    xit "prints text its given to the screen" do
      expect(subject.print("Example text")).to output("Example text").to_stdout
    end
  end

  describe "#get_option" do
    xit "prints the given message" do
      $stdin = StringIO.new("options")
      expect(subject.get_option({ message: "Example message",
                                  options: %w[example options] })).to output(/Example message/).to_stdout
    end

    xit "asks for input until it matches one of the options" do
      $stdin = StringIO.new("wrong\nstill wrong\nexample")
      expect(subject.get_option({ message: "Example message",
                                  options: %w[example options] })).to eql("example")
    end
  end

  describe "#set_global_option" do
  end
end
