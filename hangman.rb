# Dictionary class to select word
class Dictionary
  @file = '5desk.txt'
  @dictionary = File.readlines(@file)
  @min_length = 5
  @max_length = 12

  def self.choose_word
    loop do
      @word = @dictionary[rand(@dictionary.length)].gsub("\r\n", '').downcase
      break if @word.length.between?(@min_length, @max_length)
    end
    @word
  end
end

# Game class to setup hangman
class Hangman
  attr_accessor :word, :guesses_remaining, :wrong_letters_guessed, :hidden_word, :guess

  def initialize
    @word = Dictionary.choose_word
    @guesses_remaining = 6
    @wrong_letters_guessed = []
    @hidden_word = Array.new(@word.length, '_ ')
    @guess = nil
  end

  def valid_guess?(guess)
    guess.match(/[a-z]/) && guess.length == 1 && !(@wrong_letters_guessed.include? guess)
  end

  def check_guess(guess)
    if @word.include? guess
      @hidden_word.each_with_index do |_pos, index|
        @hidden_word[index] = guess + ' ' if @word[index] == guess
      end
    else
      @wrong_letters_guessed.push(guess)
      @guesses_remaining -= 1
    end
  end

  def endgame?
    !(@hidden_word.include? '_ ') || @guesses_remaining.zero?
  end
end
