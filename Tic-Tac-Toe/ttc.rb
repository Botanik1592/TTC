# Задаем хеш, который описывает содержимое ячеек на поле
matrix = { :A1 => ' ', :A2 => ' ', :A3 => ' ', :B1 => ' ', :B2 => ' ', :B3 => ' ', :C1 => ' ', :C2 => ' ', :C3 => ' ' }

# Задаем массив строк для проверки возможности блокировки победы игрока
matrixstr = [
  [:A1, :A2, :A3],
  [:B1, :B2, :B3],
  [:C1, :C2, :C3],
  [:A1, :B1, :C1],
  [:A2, :B2, :C2],
  [:A3, :B3, :C3],
  [:A1, :B2, :C3],
  [:A3, :B2, :C1]
]


# Специально для компьютера делаем еще один хеш с описанием ячеек, чтобы он мог рандомно выбирать ячейку для хода
random = { 1 => :A1, 2 => :A2, 3 => :A3, 4 => :B1, 5 => :B2, 6 => :B3, 7 => :C1, 8 => :C2, 9 => :C3}

# Функция отрисовки поля, ей мы передаем в качестве параметра хеш matrix
def print_area(pole)

  puts "    1   2   3"
  puts "  -------------"
  puts "A | #{pole[:A1] if pole[:A1]} | #{pole[:A2] if pole[:A2]} | #{pole[:A3] if pole[:A3]} |"
  puts "  -------------"
  puts "B | #{pole[:B1] if pole[:B1]} | #{pole[:B2] if pole[:B2]} | #{pole[:B3] if pole[:B3]} |"
  puts "  -------------"
  puts "C | #{pole[:C1] if pole[:C1]} | #{pole[:C2] if pole[:C2]} | #{pole[:C3] if pole[:C3]} |"
  puts "  -------------"

end

# Функция хода компои. Передаем хеш matrix, хеш рандом и массив matrixstr .
# Комп проверяет возможность заблокировать победу игрока, если ничего не предвещает беды, то
# рандомно от 1 до 9 выбираем ячейку, проверяет не занята ли оа и ходит, если нет причин против, иначе выбирает ячейку снова

def computer_choice(pole, comp, mstr)

  # Если комп ходит первым, то рандомно выбираем ячейку и обнуляем переменную, чтобы в следующий ход не повторять рандомный выбор
  if @coin == 1
    @coin = 0
    loop do
      computer = comp[rand(1..9)]       # Выбираем ячейку

      if pole[computer] == ' '          # Проверяем на занятость
         pole[computer] = 'O'            # Ходим если все ок и выходим из цикла
        return
      end
    end
  end

# Проверяем нашу позицию на возможность выиграть. Если все ок, то выходим из функции
    mstr.each do |arr|
      if pole[arr[0]] == 'O' && pole[arr[0]] == pole[arr[1]] && pole[arr[2]] == ' '
        pole[arr[2]] = 'O'
        return
      elsif pole[arr[2]] == 'O' && pole[arr[2]] == pole[arr[1]] && pole[arr[0]] == ' '
        pole[arr[0]] = 'O'
        return
      elsif pole[arr[0]] == 'O' && pole[arr[0]] == pole[arr[2]] && pole[arr[1]] == ' '
        pole[arr[1]] = 'O'
        return
      end
    end

# Проверяем позицию игрока и блокируем её при возможности и выходим из функции
    mstr.each do |arr|
      if pole[arr[0]] == 'X' && pole[arr[0]] == pole[arr[1]] && pole[arr[2]] == ' '
        pole[arr[2]] = 'O'
        return
      elsif pole[arr[2]] == 'X' && pole[arr[2]] == pole[arr[1]] && pole[arr[0]] == ' '
        pole[arr[0]] = 'O'
        return
      elsif pole[arr[0]] == 'X' && pole[arr[0]] == pole[arr[2]] && pole[arr[1]] == ' '
        pole[arr[1]] = 'O'
        return
      end
    end

    # Если блокировать нечего, то выбираем ячейку (да так, чтобы подосрать) и выходим из функции

    mstr.each do |arr|
      if pole[arr[0]] == 'O' && pole[arr[1]] == ' ' && pole[arr[1]] == pole[arr[2]]
        pole[arr[2]] = 'O'
        return
      elsif pole[arr[2]] == 'O' && pole[arr[0]] == ' ' && pole[arr[0]] == pole[arr[1]]
        pole[arr[0]] = 'O'
        return
      elsif pole[arr[0]] == 'X' && pole[arr[2]] == pole[arr[1]] && pole[arr[2]] == ' '
        pole[arr[2]] = 'O'
        return
      elsif pole[arr[2]] == 'X' && pole[arr[0]] == pole[arr[1]] && pole[arr[0]] == ' '
        pole[arr[0]] = 'O'
        return
      elsif pole[arr[0]] == ' ' && pole[arr[0]] == pole[arr[2]] && pole[arr[1]] == ' '
        pole[arr[1]] = 'O'
        return
      end
    end

    # Ну уж если подосрать не получилось, то ставим хотя бы рандомно, ходить-то надо
    loop do
      computer = comp[rand(1..9)]       # Выбираем ячейку

      if pole[computer] == ' '          # Проверяем на занятость
        pole[computer] = 'O'            # Ходим если все ок и выходим из цикла
        return
      end
    end
end

# Проверка победы. Передаем хеш matrix и массив matrixstr
def proverka_win(pole, mstr)

# Проверяем на победу
  mstr.each do |arr|
    if pole[arr[0]] == 'X' && pole[arr[0]] == pole[arr[1]] && pole[arr[0]] == pole[arr[2]]
      system 'clear'
      print_area pole
      puts 'Вы победили!'
      exit
    elsif pole[arr[0]] == 'O' && pole[arr[0]] == pole[arr[1]] && pole[arr[0]] == pole[arr[2]]
      system 'clear'
      print_area pole
      puts 'Компьютер победил!'
      exit
    end
  end

# Проверяем на ничью. Если победа не случилась до этого и пустых ячеек не осталось, то логично предположить, что у нас ничья.
  if pole.value? ' '
    return            # Если пустые ячейки еще есть, то выходим из функции
  else
    system 'clear'
    print_area pole
    puts 'Ничья!'
    exit
  end

end

# Функция хода пользователя. Передаем хеш matrix
def user_choice(pole)

  loop do

    system 'clear'

    # Печатаем поле вызовом функции отрисовки поля с хешем matrix
    print_area pole
    print "Введите номер ячейки (от А1 до С3): "
    user = gets.strip.upcase.to_sym

      # Проверка на корректность ввода
      if pole[user] == nil
        puts 'Введен несуществующий номер'

      # Проверка на занятость ячейки
      elsif pole[user] == 'X' || pole[user] == 'O'
        puts 'Ячейка занята'

      # Записываем в хеш matrix
      else
        pole[user] = 'X'
        break
      end

  end

end

# Собственно сама игра.
# Рандомно выбираем того, кто будет ходить первым, а потом тупо циклим.
@coin = rand(0..1)
if @coin == 0
  loop do
    print_area matrix
    user_choice matrix
    proverka_win matrix, matrixstr
    computer_choice matrix, random, matrixstr
    proverka_win matrix, matrixstr
  end
elsif @coin == 1
  loop do
    print_area matrix
    computer_choice matrix, random, matrixstr
    proverka_win matrix, matrixstr
    user_choice matrix
    proverka_win matrix, matrixstr
  end
end
