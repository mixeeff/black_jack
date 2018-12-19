class User
  attr_reader :name
  attr_accessor :money, :cards

  def initialize(name, money)
    @name = name
    @money = money
    @cards = []
  end

  def take_card(deck)
    @cards << deck.deal
  end

  def throw_cards
    @cards = []
  end

  def points
    sum = @cards.sum(&:weight)
    @cards.count(&:ace?).times { sum -= 10 if sum > 21 }
    sum
  end

  def move
    print '[t] - take card ' if @cards.size < 3
    puts '[o] - open cards [s] - skip [q] - quit'
    gets.chomp.upcase
  end

  def to_s
    "#{name}: #{cards.join(' ')}, #{points} points."
  end
end
