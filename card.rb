class Card
  attr_accessor :suit, :value, :weight
  def initialize(suit, value)
    @suit = suit
    @value = value
    @weight = case value
              when 2..10
                value.to_i
              when 'A'
                11
              else
                10
              end
  end

  def ace?
    value == 'A'
  end

  def to_s
    "#{value}#{suit}"
  end
end
