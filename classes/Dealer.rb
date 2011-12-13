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

  def action_loop(display)
    @players.each do |p|
      while p.status != false and p.action != 'stay'
        if p.class == Human
          display.draw
          action = human_logic(p) 
        else
          action = bot_logic(p)
        end
        call_action(p, action)
        check_bust(p)
      end
    end
    payout(@players)
    display.draw
  end

  def payout(players)
    players.each do |p|
      if p.class != Dealer
        if 1 == 1
          p.cash = p.cash + (p.bet * 2)
        else
          p.cash = p.cash - p.bet
        end
      end
    end
  end

  def check_bust(player)
    p = player
    if p.hand.total > 21
      p.status = false
    end
  end

  def call_action(player, action)
      self.send(player.action, player)
  end

  def human_logic(player)
    p = player
    actions = %w{Hit Stay Split Double}
    puts "What would you like to do?"
    actions.each do |o|
      number = actions.index(o) + 1
      puts number.to_s + ') ' + o
    end
    action = gets.chomp.to_i
    action -= 1
    puts "You chose to #{actions[action]}"
    action = actions[action].downcase
    p.action = action
    return action
  end

  def bot_logic(player)
    p = player
    case p
    when Dealer, Bot
      if player.hand.total < 17
        p.action = 'hit'
        return 'hit'
      else
        p.action = 'stay'
        return 'stay'
      end
    end
  end

  def hit(player)
    player.hand.add_card @stack.pop
  end

  def double(player)
    player.hand.add_card @stack.pop
    player.doubled = 1
  end

  def split(player)
  end

  def stay(player)
    player.action = 'stay'
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
