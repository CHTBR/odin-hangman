require "rspec"
require_relative "../lib/main_menu"

RSpec.describe MainMenu do
  let(:subject) { MainMenu.new({ player_io: @player_io, game_manager: @game_manager, load_manager: @load_manager }) }

  before do
    @player_io = double("PlayerIO", print: nil, get_option: "Exit")
    @game_manager = double("GameManager", start_new_game: nil)
    @load_manager = double("LoadManager", load_game: nil)
  end

  describe "#open_main_menu" do
    it "prints a welcome message and menu using a playerIO manager" do
      welcome_message = "Welcome to hangman"
      expect(@player_io).to receive(:print).with(welcome_message)
      subject.open_main_menu
    end

    it "prints a list of available options and asks the player to choose one using playerIO manager" do
      message = "What would you like to do?"
      options = ["Help", "Start a new game", "Load from save", "Exit"]
      expect(@player_io).to receive(:get_option).with({ message: message, options: options })
      subject.open_main_menu
    end

    context "after getting input from the player" do
      rules = "example string"

      it "accepts input until getting 'Exit'" do
        allow(@player_io).to receive(:get_option).and_return("Help", "Help", "Help", "Exit", "Help")
        expect(@player_io).to receive(:print).with(rules).exactly(3).times
        subject.open_main_menu
      end

      context "if they want to get help" do
        it "lists the rules of the game hangman and how the save/load function works" do
          allow(@player_io).to receive(:get_option).and_return("Help", "Exit")
          expect(@player_io).to receive(:print).with(rules)
          subject.open_main_menu
        end
      end

      context "if they want to start a new game" do
        it "sends a start_new_game message to the game_manager" do
          allow(@player_io).to receive(:get_option).and_return("Start a new game", "Exit")
          expect(@game_manager).to receive(:start_new_game)
          subject.open_main_menu
        end
      end

      context "if they want to load a game from save" do
        it "sends a load_game message to the load_manager" do
          allow(@player_io).to receive(:get_option).and_return("Load from save", "Exit")
          expect(@load_manager).to receive(:load_game).with(@game_manager)
          subject.open_main_menu
        end
      end
    end
  end
end
