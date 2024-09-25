require "rspec"
require_relative "../lib/save_load_manager"

require "json"

require_relative "../lib/game_manager"
require_relative "../lib/player_io"
require_relative "../lib/guess_evaluator"
require_relative "../lib/file_reader"

RSpec.describe SaveLoadManager do
  describe "#save_game" do
    before do
      @game_manager = GameManager.new({ player_io: PLayerIO.new,
                                        guess_evaluator: GuessEvaluator.new,
                                        file_reader: FileReader.new,
                                        save_manager: SaveLoadManager.new })
      @buffer = StringIO.new
      @filename = "assets/save.json"
    end

    it "converts a GameManager object into json and writes it to a file" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return("save")
      allow(File).to receive(:open).with(filename, "w").and_yield(@buffer)

      @game_manager.satrt_new_game

      expect(@buffer).to eql(@game_manager.to_json)
    end
  end

  describe "#load_game" do
  end
end
