# Class for managing writing and reading saves to and from a file
class SaveLoadManager
  def self.save_game(object)
    File.open("assets/save.json", "w") { |file| file.puts object.to_json }
  end
end
