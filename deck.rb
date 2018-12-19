require_relative('card')

class Deck
  SUITS = %w[♠ ♥ ♣ ♦].freeze
  VALUES = (2..10).to_a + %w[J Q K A]

  attr_accessor :cards

  def initialize
    @cards = []
    SUITS.each do |suit|
      VALUES.each { |value| @cards << Card.new(suit, value) }
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def deal
    @cards.shift
  end
end
