class Bank
  attr_reader :money

  def initialize
    @money = 0
  end

  def accept_bet(user, bet)
    user.money -= bet
    @money += bet
  end

  def pay_bet(user, bet)
    user.money += bet
    @money -= bet
  end
end
