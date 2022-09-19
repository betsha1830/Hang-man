class Hangman

  def copy_words
    words = File.open('/home/hp/Documents/ruby files/Hang-man/words.txt', 'r+')
  end

  def random_word_generator()
    word_list = copy_words
    counter = 0
    random = Random.new
    num_of_words = random.rand(3..5)
    random_word = ''
    until counter == num_of_words
      random_pos = random.rand(1..9894)
      random_word += " #{word_list.readlines[random_pos]}".chomp
      word_list.rewind
      counter += 1
    end
    random_word.strip!
  end

end

game = Hangman.new
puts game.random_word_generator