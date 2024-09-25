# Class responsible for handling CLI interactions with the player
class PlayerIO
  def print(message)
    puts(message)
  end

  def get_option(args)
    message = args[:message] || "Choose one of the options:"
    options = args[:options]

    puts message

    if options.size <= 5
      options.each { |option| puts "* #{option}" }
    else
      puts options.join(", ")
    end

    player_input = gets.chomp
    until options.include?(player_input)
      puts "Type one of the options"
      player_input = gets.chomp
    end
    player_input
  end
end
