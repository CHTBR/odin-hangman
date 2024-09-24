require "rspec"

Rspec.describe MainMenu do
  describe "#open_main_menu" do
    xit "prints a welcome message and menu using a playerIO manager" do
      welcome_message = "Welcome to hangman"
      expect(@player_io).to_receive(:print).with(welcome_message)
      subject.open_main_menu
    end
  end
end
