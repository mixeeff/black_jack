class Interface
  WELCOME_MESSAGE = '=== Black Jack Game. Written by D.Mikheev. 2018 ==='.freeze
  NAME_ENTER_MESSAGE = 'Enter your name: '.freeze
  MENU = ['[t]ake card', '[o]pen cards', '[s]kip'].freeze
  OPEN = 0
  TAKE_CARD = 1
  MESSAGES = ['YOU WON!', 'DRAW. Bet returns to players', 'YOU LOSE!'].freeze
  REPEAT_GAME_MESSAGE = 'Play again? (y/n) '.freeze

  def startup
    puts WELCOME_MESSAGE
    puts ''
  end

  def show_money(user, dealer, bank)
    puts '-' * 20
    puts "#{user.name} - $#{user.money}"
    puts "Dealer - $#{dealer.money}"
    puts "Bank - $#{bank.money}"
    puts '-' * 20
  end

  def user_name
    print NAME_ENTER_MESSAGE
    gets.chomp.capitalize
  end

  def user_choice(can_take)
    puts ''
    print "#{MENU[0]}, " if can_take
    print "#{MENU[1]}, #{MENU[2]} :"
    choice = gets.chomp.upcase
    return OPEN if choice == 'O'
    return TAKE_CARD if choice == 'T'

    false
  end

  def show_cards(user, dealer)
    puts user
    puts dealer
  end

  def show_result(result, _user, _dealer)
    puts "\n=== #{MESSAGES[result]} ==="
    puts ''
  end

  def repeat_game?
    print REPEAT_GAME_MESSAGE
    answer = gets.chomp.upcase
    puts ''
    answer == 'Y'
  end
end
