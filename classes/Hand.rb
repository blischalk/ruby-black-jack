class Hand
  attr_accessor :cards, :total

  def initialize
    reset  
  end

  def hand
    str = @cards.join(" ")
    str += " (#{@total})"
    return str
  end

  def add_card(card)
    @cards << card
    update_total card
  end

  def hand_hidden
    count = 0
    str = ''
    @cards.each do |c|
      case count
        when 0
          str += c
        when 1
          str += ' X'
        else
          str += ' ' + c
      end
      count += 1
    end
    return str
  end

  def reset
    @cards = []
    @total = 0
  end

  private

  def update_total card
    number = card[0..-2]
    case number
      when "J", "Q", "K"
        @total += 10
      when "A"
        @total += 11
        if @total > 21
          @total -= 11
          @total += 1
        end
      else
        @total += number.to_i
    end
  end
end
