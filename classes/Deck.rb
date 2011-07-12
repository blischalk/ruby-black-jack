class Deck
  attr_reader :values, :suits

  def initialize
    @values = ['A',2,3,4,5,6,7,8,9,10,'J','Q','K']
    @suits = %w{ c d h s}
  end
end

