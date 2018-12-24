require_relative('card')
require_relative('deck')
require_relative('hand')
require_relative('game')
require_relative('interface')

class Main
  START_MONEY = 100
  START_CARD_COUNT = 2
  BET = 10
  DEALER_NAME = 'Dealer'.freeze

  def initialize
    @interface = Interface.new
  end

  def run
    @interface.startup
    name = @interface.user_name
    user = Hand.new(name, START_MONEY)
    dealer = Hand.new(DEALER_NAME, START_MONEY)

    loop do
      game = Game.new(user, dealer, BET, @interface)
      game.run
      break unless @interface.repeat_game?
    end
  end
end

app = Main.new
app.run
