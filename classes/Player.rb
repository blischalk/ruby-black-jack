class Player
  attr_accessor :name, :pos, :hand, :status, :action, :cash, :bet
  
  def initialize
    @hand = Hand.new
    @cash = 100
    @bet = 0
    @status = :playing
  end

  def place_bet
  end
end

class ActivePlayer < Player
  def place_bet
    @bet += 25
    @cash -= 25
  end
end

class Human < ActivePlayer
  def initialize
    super
    set_name
    set_pos
  end
  def set_name
    @name = 'Brett' #name
  end

  def set_pos
    @pos = 1
  end
end

class Bot < ActivePlayer
  def initialize
    super
    set_name
    set_pos
  end

  def set_pos
    @pos = [2,4].pop
  end

  def set_name
    @name = ['George', 'Lucky', 'Manny', 'Nikki', 'Carl'].sort_by {rand}.pop
  end
end
