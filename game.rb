require_relative('card')
require_relative('deck')
require_relative('hand')
require_relative('bank')

class Game
  USER_WON = 0
  DRAW = 1
  DEALER_WON = 2

  attr_accessor :user, :dealer, :deck
  attr_reader :bet, :bank

  def initialize(user, dealer, bet, interface)
    @deck = Deck.new
    @user = user
    @dealer = dealer
    @bet = bet
    @interface = interface
    @bank = Bank.new
  end

  def user_move
    choice = @interface.user_choice(!user.three_cards?)
    if choice == Interface::TAKE_CARD
      user.take_card(deck)
      return false
    end
    choice == Interface::OPEN
  end

  def dealer_move
    dealer.take_card(deck) if dealer.cards.size < 3 && dealer.points < 17
  end

  def prepare_round
    make_bet
    @interface.show_money(user, dealer, @bank)
    deck.shuffle
    user.throw_cards
    dealer.throw_cards
    dealer.close_cards
    2.times { user.take_card(@deck) }
    2.times { dealer.take_card(@deck) }
  end

  def round
    @interface.show_cards(user, dealer)
    loop do
      return if user_move

      dealer_move
      @interface.show_cards(user, dealer)
      return if user.three_cards? && dealer.three_cards?
    end
  end

  def make_bet
    bank.accept_bet(user, bet)
    bank.accept_bet(dealer, bet)
  end

  def count_results
    return DRAW if user.black_jack? && dealer.black_jack?
    return USER_WON if user.black_jack?
    return DEALER_WON if dealer.black_jack?
    return DEALER_WON if user.overload?
    return USER_WON if dealer.overload?
    return DRAW if dealer.points == user.points

    user.points > dealer.points ? USER_WON : DEALER_WON
  end

  def calc_money(result)
    case result
    when DRAW
      bank.pay_bet(user, bet)
      bank.pay_bet(dealer, bet)
    when USER_WON
      bank.pay_bet(user, bet * 2)
    when DEALER_WON
      bank.pay_bet(dealer, bet * 2)
    end
  end

  def run
    prepare_round
    round
    result = count_results
    calc_money(result)
    @interface.show_result(result, user, dealer)
    @interface.show_money(user, dealer, bank)
  end
end
