# Shotgun Rock, Paper, Scissors v1
# by Andy Wong

require 'pry'

class Hand
  attr_reader :type
  def initialize(type = nil)
    if  type == nil
      @type = %w[rock paper scissors].sample
    else
      @type = type
    end
  end

  def change(type)
    @type = type
  end
end

class Player
  attr_reader :throws
  def initialize
    @throws = []
    5.times { @throws << Hand.new } # will replace this once player input is made
  end

# working on

  def input(choice)
    choice = choice
    @throws << Hand.new(choice)
  end

# working on


end

class Computer
  attr_reader :throws
  def initialize
    @throws = []
    5.times { @throws << Hand.new }
  end
end


class Match
  attr_reader :score, :player, :computer, :player_score, :comp_score
  def initialize
    @beats = {'rock' => 'paper',
              'paper' => 'scissors',
              'scissors' => 'rock'}
    @score = {'player' => 0,
              'computer' => 0}
  end

  def rules
    puts "Welcome to Shotgun: Rocks, Paper, Scissors!"
    puts
    puts "The rules: Each player makes 5 choices per round."
    puts "Whoever wins the majority of these choices earns a score point!"
    puts
    puts "Let's play!"
  end

  def throw
    @player = []
    @computer = []

    player = Player.new
    computer = Computer.new

    player.throws.each do |throws|
      @player << throws.type
    end

    computer.throws.each do |throws|
      @computer << throws.type
    end
  end

  def compare(player, computer)

    @player_score = 0
    @comp_score = 0

    if player == computer
      puts "PLAYER: #{player} - COMPUTER: #{computer} - [DRAW]"
    elsif player == @beats[computer]
      puts "PLAYER: #{player} - COMPUTER: #{computer} - [Player WINS]"
      @player_score += 1
    else
      puts "PLAYER: #{player} - COMPUTER: #{computer} - [Computer WINS]"
      @comp_score += 1
    end

  end

  def wins
    fight = @player.zip @computer

    fight.each do |player, computer|
      compare(player,computer)
    end

    if @player_score > @comp_score
      puts "\nROUND WINNER: Player scores!"
      @score['player'] += 1
    else
      @score['computer'] += 1
      puts "\nROUND WINNER: Computer scores!"
    end
    puts "\nCURRENT SCORE:"
    puts "PLAYER: #{@score['player']} -- COMPUTER: #{@score['computer']}"
  end

  def play
    throw
    wins
  end

end

binding.pry
