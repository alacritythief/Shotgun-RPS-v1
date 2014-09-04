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
    5.times { request_input } # needs proper check for wrong input
  end

# working on

  def request_input
    choice_hash = {1 => 'rock', 2 => 'paper', 3 => 'scissors'}
    puts "\nMake your choice. Enter a number key:"
    puts "1) rock, 2) paper, or 3) scissors"
    print "> "
    choice = choice_hash[gets.to_i]
    @throws << Hand.new(choice)
    puts "\nYour current picks:"
    print "[ "
    @throws.each do |hand|
      print "#{hand.type} "
    end
    puts "]"

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

    @player_score = 0
    @comp_score = 0

    fight = @player.zip @computer

    puts "\n--------------------------"
    puts "BLAM! SHOTS FIRED! BATTLE!"
    puts "--------------------------"

    fight.each do |player, computer|
      sleep(1)
      compare(player,computer)
    end

    if @player_score > @comp_score
      puts "\nROUND WINNER: PLAYER!"
      @score['player'] += 1
    elsif @player_score == @comp_score
      puts "\nDRAW! No one scores."
    else
      puts "\nROUND WINNER: COMPUTER!"
      @score['computer'] += 1
    end
    puts "\nCURRENT SCORE:"
    puts "PLAYER: #{@score['player']} -- COMPUTER: #{@score['computer']}"
  end

  def clear
    @score = {'player' => 0,
              'computer' => 0}
    puts "SCOREBOARD CLEARED"
  end

  def play
    rules
    throw
    wins
  end

end

game = Match.new

binding.pry
