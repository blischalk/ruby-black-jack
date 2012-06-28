class Dealer < Player
  attr_reader :deck_count, :decks, :stack
  attr_accessor :blackjack

  def run_game
    get_ante
    deal
    action_loop
  end

  def get_ante
    puts "Place your bets!"
    @blackjack.players.each do |p|
      p.place_bet
    end
  end

  def deal
    @blackjack.players.each do |p|
      p.hand.add_card @stack.pop 
    end
  end

  def action_loop
    @blackjack.players.each do |p|
      while p.status != false and p.action != 'stay'
        if p.class == Human
          @blackjack.display.draw
          human_logic(p) 
        else
          bot_logic(p)
        end
        call_action(p)
        check_bust(p)
        set_winners(p)
      end
    end
    payout
    @blackjack.display.draw
  end

  def human_logic(player)
    puts "What would you like to do?"
    @blackjack.actions.each do |o|
      number = @blackjack.actions.index(o) + 1
      puts number.to_s + ') ' + o
    end
    action = gets.chomp.to_i - 1
    puts "You chose to #{@blackjack.actions[action]}"
    player.action = @blackjack.actions[action].downcase
  end

  def bot_logic(player)
    case player
    when Dealer, Bot
      if player.hand.total < 17
        player.action = 'hit'
      else
        player.action = 'stay'
      end
    end
  end

  def call_action(player)
    self.send(player.action, player)
  end

  def check_bust(player)
    if player.hand.total > 21
      player.status = false
    end
  end

  def set_winners(player)
    if player.status != false && player.hand.total > self.hand.total
      player.status = 'winner'
    end
  end

  def payout
    @blackjack.players.each do |p|
      if p.class != Dealer
        if p.status == 'winner'
          p.cash = p.cash + (p.bet * 2)
        else
          p.cash = p.cash - p.bet
        end
      end
    end
  end

  def setup
    @deck_count = Array.new(2) #Array.new(set_deck_count)
    @stack = get_stack
    self.shuffle
  end

  def modify_options(options, player)
    options.pop
    options.pop
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
