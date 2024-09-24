# A class for managing player options on game start
class MainMenu
  def initialize(args)
    @player_io = args[:player_io]
  end

  def open_main_menu
    @player_io.print("Welcome to hangman")
    @player_io.get_option({ message: "What would you like to do?",
                            options: ["Help", "Start a new game", "Load from save"] })
    @player_io.print("example string")
  end
end
