class Dealer < Player
  attr_reader :deck_count, :decks, :stack

  def setup
    @deck_count = Array.new(set_deck_count)
    @stack = get_stack
    self.shuffle
  end

  def set_pos
    return 3
  end

  def deal(players)
    count = 0
    while count < 2
      players.each do |p|
        p.hand[:cards] << @stack.pop 
      end
      count += 1
    end
  end

  def set_name
    return 'Dealer'
  end

  def set_deck_count
    valid = false
    while valid == false
      puts "Please select how many decks (1-4) you would like to play with..."
      decks = gets.chomp.to_i
      if decks >= 1 && decks <= 4
        valid = true
        puts "Thank you.  We will be playing with " + Helper.pluralize(decks, 'deck')
        return decks
      end
      puts "Please make sure your enter a value between 1 and 4"
    end
  end

  def get_stack
    stack = []
    deck = Deck.new
    @deck_count.each do
      deck.values.each do |v|
        deck.suits.each do |s|
          stack << "#{v}#{s}" 
        end
      end
    end
    return stack
  end
  
  def shuffle
    @stack =  @stack.sort_by {rand}
  end

  def place_bet
  end
end
