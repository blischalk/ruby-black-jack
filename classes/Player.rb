class Player
  attr_accessor :name, :pos, :hand
  def initialize
    @name = self.set_name
    @hand = {:cards => [], :value => 0}
    @pos = self.set_pos
    self.setup
  end

  def setup
  end

  def display_hand
    str = @hand[:cards].join(" ")
    str += " (#{@hand[:value]})"
    return str
  end

end

class ActivePlayer < Player
  attr_accessor :bet, :cash
  def initialize
    @cash = 100
    @bet = 0
    super()
  end

  def place_bet
    @bet += 25
    @cash -= 25
  end

end

class Human < ActivePlayer
  def set_name
      puts "Please enter your name..."
      name = gets.chomp
      puts "Thank you #{name}."  
      return name
  end
  def set_pos
    return 1
  end

end

class Bot < ActivePlayer
  @@names = ['Tiffany', 'Lucky', 'Manny', 'Nikki', 'Kayla']
  @@pos = [2,4]
  def set_pos
    @@pos.pop
  end

  def set_name
    @@names = @@names.sort_by {rand}
    @@names.pop
  end


end

