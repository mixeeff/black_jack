require_relative('card')
require_relative('deck')
require_relative('user')
require_relative('dealer')

USER_WON = 0
DRAW = 1
DEALER_WON = 2
MESSAGES = ['YOU WON!', 'DRAW. Bet returns to players', 'YOU LOSE!'].freeze

class Game
  def initialize(user, dealer, bet)
    @deck = Deck.new
    @user = user
    @dealer = dealer
    @bet = bet
  end

  def make_bet
    @user.money -= @bet
    @dealer.money -= @bet
  end

  def count_results
    return DRAW if @dealer.points > 21 && @user.points > 21
    return DRAW if @dealer.points == @user.points
    return DEALER_WON if @user.points > 21
    return USER_WON if @user.points == 21
    return USER_WON if @dealer.points > 21

    @user.points > @dealer.points ? USER_WON : DEALER_WON
  end

  def calc_money(result)
    case result
    when DRAW
      @user.money += @bet
      @dealer.money += @bet
      nil
    when USER_WON
      @user.money += @bet * 2
    when DEALER_WON
      @dealer.money += @bet * 2
    end
  end

  def show_result(result)
    puts "\n=== #{MESSAGES[result]} ==="
    puts "#{@user.name} - $#{@user.money}"
    puts "Dealer - $#{@dealer.money}"
    puts ''
  end

  def run
    @deck.shuffle
    @user.throw_cards
    @dealer.throw_cards
    @dealer.close_cards

    2.times { @user.take_card(@deck) }
    2.times { @dealer.take_card(@deck) }
    result = -1
    choice = ''
    make_bet
    loop do
      puts @user
      puts @dealer
      choice = @user.move
      break if choice == 'Q' || choice == 'O'

      @user.take_card(@deck) if choice == 'T'
      @dealer.move(@deck)
      break if @user.cards.size == 3 && @dealer.cards.size == 3
    end
    unless choice == 'Q'
      puts ' === ROUND FINISHED === '
      @dealer.open_cards
      puts @user
      puts @dealer
      result = count_results
      calc_money(result)
      show_result(result)
    end
    choice != 'Q'
  end
end
