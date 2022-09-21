class Hangman

  def initialize
    @num_of_guesses_left = 13
    @guessed_letters = []
    @random_word = random_word_generator
    @secret_word = []
  end

  def game
    word = ''
    random_word = word_to_dash(@random_word)
    dash_to_word(random_word)
    print_checked_answer
    until @num_of_guesses_left == 0 || word == @random_word
      user_input
      dash_to_word(random_word)
      print_checked_answer
      word = check_guessed_word
    end

    if word == @random_word
      puts "Congrats you've won the game."
    else
      puts "Ahhh! You've lost but the secret words are: #{readable_word}"
    end
  end

  def readable_word
    readable_word = ''
    @random_word.each {|word| readable_word = "#{readable_word} #{word}"}
    readable_word
  end

  def user_input
    @input = ''
    puts "please enter your guess: \b"
    @input = gets.chomp
    @guessed_letters.push(@input)
  end

  def string_to_arr(string)
    arr = []
    string.each_char do |char|
      arr.push(char)
    end
    arr
  end

  def arr_to_string(arr)
    string = ''
    arr.each do |item|
      string.concat(item)
    end
    string
  end
  
  def copy_words
    words = File.open('words.txt', 'r+')
  end

  def random_word_generator
    word_list = copy_words
    counter = 0
    random = Random.new
    num_of_words = random.rand(2..3)
    random_word = []
    until counter == num_of_words
      random_pos = random.rand(1..9894)
      random_word.push(word_list.readlines[random_pos].chomp)
      word_list.rewind
      counter += 1
    end
    random_word
  end

  def word_to_dash(random_word)
    secret_word = ''
    dashed_secret_word = []
    counter = 0
    until counter == random_word.length
      word = random_word[counter].to_s
      word.each_char do |char|
        secret_word += '_ '
      end
      counter += 1
      dashed_secret_word.push(secret_word.strip)
      secret_word = ''
    end
    dashed_secret_word
  end

  def dash_to_word(dashed_word)
    counter = 0
    incorrect_guess = 0
    until dashed_word.length == counter
      word = string_to_arr(@random_word[counter].to_s)
      dashes = string_to_arr(dashed_word[counter].to_s)
      @guessed_letters
      word.each_with_index do |item, index|
        @guessed_letters.each do |letter|
          if word[index] == letter
            dashes[index * 2] = word[index]
          end
        end
      end

      word.any?(@input) ? '' : incorrect_guess += 1
      dashes = arr_to_string(dashes)
      @secret_word[counter] = dashes
      counter += 1
    end
    incorrect_guess == @random_word.length ? @num_of_guesses_left -= 1 : ''
    @secret_word
  end

  def check_guessed_word
    clean_word = []
    counter = 0
    until counter == @secret_word.length
      @secret_word.each do |word|
        word.each_char do |char|
          char != ' ' ? clean_word[counter] = "#{clean_word[counter]}#{char}" : ''
        end
        counter += 1
      end
    end
    clean_word
  end

  def print_checked_answer
    checked_answer = ''
    @secret_word.each do |item|
      checked_answer += "#{item}    "
    end
    puts "#{checked_answer.strip!}  Number of guesses left: #{@num_of_guesses_left}  Guessed letters: #{arr_to_string(@guessed_letters)}"
  end
end

hang = Hangman.new
puts hang.game