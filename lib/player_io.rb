# Class responsible for handling CLI interactions with the player
class PlayerIO
  def initialize
    @global_options = []
  end

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

    options = options + @global_options
    player_input = gets.chomp
    until options.include?(player_input)
      puts "Type one of the options"
      player_input = gets.chomp
    end
    player_input
  end

  def add_global_option(option)
    @global_options << option
  end
end
