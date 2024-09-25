require "rspec"
require_relative "../lib/player_io"

RSpec.describe PlayerIO do
  describe "#print" do
    it "prints text its given to the screen" do
      expect { subject.print("Example text") }.to output(/Example text/).to_stdout
    end
  end

  describe "#get_option" do
    it "prints the given message" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return("example")
      expect do
        subject.get_option({ message: "Example message",
                             options: %w[example options] })
      end.to output(/Example message/).to_stdout
    end

    it "asks for input until it matches one of the options" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return("wrong", "still wrong", "example")
      expect(subject.get_option({ message: "Example message",
                                  options: %w[example options] })).to eql("example")
    end

    it "prints a warning message when input is incorrect" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return("wrong", "still wrong", "example")
      expect do
        subject.get_option({ message: "Example message",
                             options: %w[example options] })
      end.to output(/Type one of the options/).to_stdout
    end

    context "when given 5 or less options" do
      it "prints them in a bullet list" do
        options = %w[example options are very cool]
        allow_any_instance_of(Kernel).to receive(:gets).and_return("example")
        $stdout = StringIO.new
        subject.get_option({ message: "Example message",
                             options: options })
        stdout = $stdout.string
        options.each do |option|
          expect(stdout.include?("* " + option)).to eql(true)
        end
      end
    end

    context "when given more than 5 options" do
      xit "prints them in a line" do
        options = %w[example options are very cool indeed]
        $stdin = StringIO.new("example")
        $stdout = StringIO.new
        subject.get_option({ message: "Example message",
                             options: options })
        stdout = $stdout.string
        expect(stdout.include?(options.join(", "))).to eql(true)
      end
    end
  end

  describe "#set_global_option" do
    xit "allows you to select the given option in any #get_option call" do
      player_io = subject
      player_io.set_global_option("bonus")
      $stdin = StringIO.new("bonus")
      expect(player_io.get_option({ message: "Example message",
                                    options: %w[example options] })).to eql("bonus")
    end
  end
end
