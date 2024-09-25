require "json"

# Class for saving and loading a game object through json
class SaveLoadManager
  def save_game(object)
    File.open("assets/save.json", "w") do |file|
      file.puts(object.to_json)
    end
  end
end
