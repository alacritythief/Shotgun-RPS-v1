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
    5.times { @throws << Hand.new }
  end
end

class Computer
  attr_reader :throws
  def initialize
    @throws = []
    5.times { @throws << Hand.new }
  end
end


class Match
  attr_reader :score, :player, :computer
  def initialize
    @beats = {'rock' => 'paper',
              'paper' => 'scissors',
              'scissors' => 'rock'}
    @score = {'player' => 0,
              'computer' => 0}
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
        puts "Draw"
      elsif player == @beats[computer]
        puts "Human wins"
      else
        puts "Computer wins"
      end
  end

  def wins
    fight = @player.zip @computer

    fight.each do |player, computer|
      compare(player,computer)
    end
  end

end


# test.throws[0].type - gives direct hand


binding.pry
