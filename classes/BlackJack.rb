class BlackJack
  attr_accessor :players, :player, :dealer, :bots
  def initialize
    greeting #Verified
    # 1 for new game
    # 2 for continued game
    # verified
    status = get_status
    # pass the status into our setup function
    setup status #verified
    run
  end

  def run
    @dealer.get_ante
    @dealer.deal
    @dealer.action_loop @display
  end

  def setup(status)
    if status == 1
      @players = self.get_players
      @dealer.players = @players
      @display = Display.new(@players)
      else
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

  def get_status
    valid = false
    puts "1) New Game \n2) Continue"
    while valid == false
    action = gets.chomp.to_i
      case action
        when 1
          ret = 1
          valid = true
        when 2
          puts "Continuing a previous game"
          ret = 2
          valid = true
        else
          puts "Please select either 1 or 2"
      end
      return ret
    end
  end

  def greeting
    puts "Welcome to Brett's Blackjack"
  end
end

