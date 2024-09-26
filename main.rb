require_relative "lib/main_menu"
require_relative "lib/game_manager"
require_relative "lib/player_io"
require_relative "lib/guess_evaluator"
require_relative "lib/file_reader"
require_relative "lib/save_load_manager"

player_io = PlayerIO.new
guess_evaluator = GuessEvaluator.new
file_reader = FileReader
save_load_manager = SaveLoadManager
game_manager = GameManager.new({ file_reader: file_reader, guess_evaluator: guess_evaluator, player_io: player_io, save_manager: save_load_manager })
main_menu = MainMenu.new( player_io: player_io, game_manager: game_manager, load_manager: save_load_manager )
main_menu.open_main_menu

