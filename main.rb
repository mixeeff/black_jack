require_relative('card')
require_relative('deck')
require_relative('user')
require_relative('dealer')
require_relative('game')

class Main
  START_MONEY = 100
  START_CARD_COUNT = 2
  BET = 10

  def run
    puts ' === Black Jack Game. Written by D.Mikheev. 2018 === '
    print 'Enter your name: '
    name = gets.chomp.capitalize
    puts ''
    user = User.new(name, START_MONEY)
    dealer = Dealer.new(START_MONEY)

    loop do
      game = Game.new(user, dealer, BET)
      break unless game.run

      print 'Play again? '
      choice = gets.chomp.upcase
      break unless choice == 'Y'

      puts ''
    end
  end
end

app = Main.new
app.run
