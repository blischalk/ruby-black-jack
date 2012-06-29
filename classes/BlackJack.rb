class BlackJack
  attr_accessor :players, :player, :dealer, :bots, :display
  def initialize
    greeting
    # 1 for new game
    # 2 for continued game
    game_init
    setup
    @dealer.blackjack = self
    @dealer.run_game
  end

  def greeting
    puts "Welcome to Brett's Blackjack"
  end

  def game_init
    valid = false
    puts "1) New Game \n2) Continue"
    while valid == false
      #get user input
      start_option = gets.chomp.to_i

      #valid input options
      valid_input = [1,2]

      if valid_input.include? start_option
        # set an instance variable of the option the user selected
        @start_option = start_option

        # break out of the loop
        valid = true
      end

      if start_option == 2
        puts "Continuing a previous game"
      end

      unless valid_input.include? start_option
        puts "Please select either 1 or 2"
      end
    end
  end

  def setup
    if @start_option == 1
      get_players
      get_display
    end
  end

  def get_players
    @players = []
    @player = Human.new
    @dealer = Dealer.new

    get_bots

    @players << @dealer << @player
    @bots.each do |b|
      @players << b
    end
    @players.sort! { |a,b| a.pos <=> b.pos}
  end

  def get_bots
    @bots = Array.new()
    2.times do
      @bots << Bot.new
    end
  end

  def get_display
    @display = Display.new(@players)
  end

  def actions
    %w{Hit Stay Split Double}
  end
end

