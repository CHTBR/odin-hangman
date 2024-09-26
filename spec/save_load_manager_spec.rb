require "rspec"
require_relative "../lib/save_load_manager"
require_relative "game_manager_double"

RSpec.describe SaveLoadManager do
  let(:subject) { SaveLoadManager }

  describe "#save_game" do
    it "takes the object json representation and saves it to a file" do
      file_double = StringIO.new
      allow(File).to receive(:open).with("assets/save.json", "w").and_yield(file_double)
      game_manager_double = GameManagerDouble.new
      subject.save_game(game_manager_double)
      expect(file_double.string.chomp).to eql(game_manager_double.json_representation)
    end
  end

  describe "#load_game" do
    it "reads from save file and creates a new object" do
      game_manager_double = GameManagerDouble.new
      file_double = StringIO.new(game_manager_double.json_representation)
      allow(File).to receive(:read).with("assets/save.json").and_return(file_double.string)
      expect { subject.load_game(game_manager_double) }.to output("initialized variables with target, t _ r _ _ t, 1, 3, a b c d e f g h i j k l m n p q s u v w x y z").to_stdout
    end
  end
end
