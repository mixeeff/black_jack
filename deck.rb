require_relative('card')

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::VALUES.each { |value| @cards << Card.new(suit, value) }
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def deal
    @cards.shift
  end
end
