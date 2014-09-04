# SHOTGUN: Rock, Paper, Scissors v1.0
# by Andy Wong

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
  attr_accessor :health, :throws
  def initialize(hitpoints)
    @throws = []
    @health = hitpoints
  end

#### need better working input ####

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

#### need better working input ####

end

class Computer
  attr_accessor :health, :throws
  def initialize(hitpoints)
    @throws = []
    @health = hitpoints
  end
end

class Match
  attr_reader :score, :player, :computer, :player_score, :comp_score
  def initialize
    @beats = {'rock' => 'paper',
              'paper' => 'scissors',
              'scissors' => 'rock'}
    @player = Player.new(10)
    @computer = Computer.new(10)
  end

  def rules
    puts "-------------------------------------------"
    puts "Welcome to SHOTGUN: Rocks, Paper, Scissors!"
    puts "-------------------------------------------"
    sleep(1)
    puts
    puts "The rules: Each player makes 5 choices per round."
    sleep(1)
    puts "Whoever wins the round damages their opponent!"
    sleep(1)
    puts
    puts "LET'S PLAY!"
    sleep(1)
  end

  def throw
    @player_throws = []
    @computer_throws = []

    @player.throws = []
    @computer.throws = []

    5.times { @player.request_input } # needs proper check for wrong input
    5.times { @computer.throws << Hand.new }

    @player.throws.each do |throws|
      @player_throws << throws.type
    end

    @computer.throws.each do |throws|
      @computer_throws << throws.type
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

    fight = @player_throws.zip @computer_throws

    puts "\n--------------------------"
    puts "BLAM! SHOTS FIRED! BATTLE!"
    puts "--------------------------"

    sleep(1)

    fight.each do |player, computer|
      sleep(0.5)
      compare(player,computer)
    end

    if @player_score > @comp_score
      print "\nROUND WINNER: "
      sleep(1)
      puts "PLAYER!"
      @computer.health = @computer.health -= 1
    elsif @player_score == @comp_score
      print "\nROUND WINNER: "
      sleep(1)
      puts "DRAW! No one gets hurt."
    else
      print "\nROUND WINNER: "
      sleep(1)
      puts "COMPUTER!"
      @player.health = @player.health -= 1
    end
    sleep(1)
    puts "\nCURRENT HEALTH:"
    puts "PLAYER: #{@player.health}HP -- COMPUTER: #{@computer.health}HP"
  end

  def clear
    @player.health = 10
    @computer.health = 10
    puts "HITPOINTS RESTORED"
    puts "PLAYER: #{@player.health}HP -- COMPUTER: #{@computer.health}HP"
  end
end

class Game
  def self.play
    @game = Match.new
    @game.rules
    @game.throw
    @game.wins
    Game.winning_condition
  end

  def self.play_another?
    puts "\nPlay another round (Y/N)?"
    print "> "
    input = gets.chomp.downcase
    if input == "y"
      Game.continue
    else
      puts "\nGoodbye! Thanks for playing!"
      exit
    end
  end

  def self.continue
    @game.throw
    @game.wins
    Game.winning_condition
  end

  def self.winning_condition
    if @game.player.health <= 0
      puts "----------------------------------"
      puts "PLAYER HAS BEEN DEFEATED - THE END"
      puts "----------------------------------"
      exit
    elsif @game.computer.health <=0
      puts "----------------------------------"
      puts "COMPUTER HAS BEEN DEFEATED - THE END"
      puts "----------------------------------"
      exit
    else
      Game.play_another?
    end
  end
end

Game.play
