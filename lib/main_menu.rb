# A class for managing player options on game start
class MainMenu
  def initialize(args)
    @player_io = args[:player_io]
  end

  def open_main_menu
    @player_io.print("Welcome to hangman")
  end
end
