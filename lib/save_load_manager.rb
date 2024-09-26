# Class for managing writing and reading saves to and from a file
class SaveLoadManager
  def self.save_game(object)
    File.open("assets/save.json", "w") { |file| file.puts object.to_json }
  end

  def self.load_game(object)
    object.parse_json(File.read("assets/save.json"))
  end
end
