# Class responsible for handling CLI interactions with the player
class PlayerIO
  def print(message)
    puts(message)
  end

  def get_option(args)
    message = args[:message] || "Choose one of the options:"
    options = args[:options]
    puts message
  end
end
