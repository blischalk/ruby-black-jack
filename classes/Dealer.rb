class Dealer < Player
  attr_reader :deck_count, :decks, :stack
  attr_accessor :players

  def setup
    @deck_count = Array.new(2) #Array.new(set_deck_count)
    @stack = get_stack
    self.shuffle
  end

  def modify_options(options, player)
    options.pop
    options.pop
  end

  def get_ante
    puts "Place your bets!"
      @players.each do |p|
        p.place_bet
      end
  end

  def fallout
    @players.each do |p|
      if p.hand.total > 21
        p.status = false
      end
    end
  end

  def prompt_action
    options = %w{Hit Stay Split Double}
    @players.each do |p|
      modify_options(options, p)
      if p.class == Human
        puts "What would you like to do?"
        options.each do |o|
          number = options.index(o) + 1
          puts number.to_s + ') ' + o
        end
        action = gets.chomp.to_i
        action -= 1
        puts "You chose to #{options[action]}"
        p.action = options[action].downcase
      end
      parse_action(p)
    end
  end

  def hit(player)
    puts 'hitting'
    player.hand.add_card @stack.pop
  end

  def double(player)
    puts 'doubling'
    player.hand.add_card @stack.pop
    player.doubled = 1
  end

  def split(player)
    puts 'splitting'
  end

  def stay(player)
    puts 'staying'
  end

  def parse_action(player)
    if player.class == Human && player.action != nil
      self.send(player.action, player)
    else
      self.action_logic(player)
    end
  end

  def action_logic(player)
    
    case player
    when Dealer
      puts 'Dealer move'
      if player.hand.total < 17
        hit(player)
      else
        stay(player)
      end
    when Bot
      puts 'Bot Move'
      if player.hand.total < 17
        hit(player)
      else
        stay(player)
      end
    end
  end
  
  def set_pos
    return 3
  end

  def deal
    count = 0
    while count < 2
      @players.each do |p|
        p.hand.add_card @stack.pop 
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
