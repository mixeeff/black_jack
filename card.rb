class Card
  SUITS = %w[♠ ♥ ♣ ♦].freeze
  VALUES = (2..10).to_a + %w[J Q K A]

  attr_accessor :suit, :value, :weight
  def initialize(suit, value)
    @suit = suit
    @value = value
    @weight = weight_by_value
  end

  def weight_by_value
    return value if value.to_i.between?(2, 10)
    return 11 if ace?

    10
  end

  def ace?
    value == 'A'
  end

  def to_s
    "#{value}#{suit}"
  end
end
