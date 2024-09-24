require "rspec"

Rspec.describe MainMenu do
  describe "#open_main_menu" do
    xit "prints a welcome message and menu using a playerIO manager" do
      welcome_message = "Welcome to hangman"
      expect(@player_io).to_receive(:print).with(welcome_message)
      subject.open_main_menu
    end

    xit "prints a list of available options and asks the player to choose one using playerIO manager" do
      message = "What would you like to do?"
      options = ["Help", "Start a new game", "Load from save"]
      expect(@player_io).to_receive(:get_option).with({ message: message, options: options })
      subject.open_main_menu
    end
  end
end
