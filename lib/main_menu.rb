# A class for managing player options on game start
class MainMenu
  def initialize(args)
    @player_io = args[:player_io]
    @game_manager = args[:game_manager]
  end

  def open_main_menu
    @player_io.print("Welcome to hangman")
    player_action = @player_io.get_option({ message: "What would you like to do?",
                                            options: ["Help", "Start a new game", "Load from save"] })

    case player_action
    when "Help"
      @player_io.print("example string")
    when "Start a new game"
      @game_manager.start_new_game
    end
  end
end
