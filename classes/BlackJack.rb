class BlackJack
  attr_accessor :player
  attr_reader :dealer, :bots, :player, :players
  def initialize
    greeting
    get_status
    setup @game
    run
  end

  def setup(game)
    if game == 1
      @players = self.get_players
      else
    end
  end

  def run
    @dealer.deal @players
    puts "Place your bets!"
    @players.each do |p|
      p.place_bet
    end
    @display = Display.new(@players)
  end

  def get_players
    @player = Human.new
    @dealer = Dealer.new
    @bots = self.get_bots

    ret = []
    ret << @dealer << @player
    @bots.each do |b|
      ret << b
    end
    ret.sort! { |a,b| a.pos <=> b.pos}
    return ret
  end

  def greeting
    puts "Welcome to Brett's Blackjack"
  end

  def get_status
    valid = false
    puts "1) New Game \n2) Continue"
    while valid == false
    action = gets.chomp.to_i
      case action
        when 1
          @game = 1
          valid = true
        when 2
          puts "Continuing a previous game"
          @game = 2
          valid = true
        else
          puts "Please select either 1 or 2"
      end
    end
  end

  def get_bots
    bots = Array.new()
    count = 0
    while count < 2
      bots << Bot.new
      count += 1
    end
    return bots
  end
end

