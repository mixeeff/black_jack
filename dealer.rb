class Dealer < User
  attr_accessor :card_opened

  def initialize(money)
    super('Dealer', money)
    @card_opened = false
  end

  def to_s
    if @card_opened
      super
    else
      cards = '* ' * @cards.size
      "#{name}: #{cards}"
    end
  end

  def open_cards
    @card_opened = true
  end

  def close_cards
    @card_opened = false
  end

  def move(deck)
    return if points >= 17

    take_card(deck) if @cards.size < 3
  end
end
