class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses
  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @word_with_guesses = '-' * word.length
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
    throw ArgumentError if letter == nil or letter.match(/[A-Za-z]/).nil?

    rexp = /#{letter}/i
    valid = (@guesses.match(rexp).nil? and @wrong_guesses.match(rexp).nil?)

    if valid
      found = !@word.match(rexp).nil?
      if found
        @guesses = @guesses + letter
        @word_with_guesses = @word.gsub(/[^#{@guesses}]/, '-')
      else
        @wrong_guesses = @wrong_guesses + letter
      end
    end

    return valid
  end

  def check_win_or_lose
    if @word == @word_with_guesses
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end

end
