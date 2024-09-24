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

    context "after getting input from the player" do
      context "if they want to get help" do
        xit "lists the rules of the game hangman and how the save/load function works" do
          rules = "example string"
          allow(@player_io).to_receive(:get_option).and_return("Help")
          expect(@player_io).to_receive(:print).with(rules)
          subject.open_main_menu
        end
      end

      context "if they want to start a new game" do
        xit "sends a start_new_game message to the game_manager" do
          allow(@player_io).to_receive(:get_option).and_return("Start a new game")
          expect(@game_manager).to_receive(:start_new_game)
          subject.open_main_menu
        end
      end

      context "if they want to load a game from save" do
        xit "sends a load_game message to the load_manager" do
          allow(@player_io).to_receive(:get_option).and_return("Load from save")
          expect(@load_manager).to_receive(:load_game)
          subject.open_main_menu
        end
      end
    end
  end
end
