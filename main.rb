require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'hangman.rb'

configure do
  enable :sessions
end

get '/' do
  erb :index
end

post '/' do
  session[:hangman] = Hangman.new
  redirect to('/game')
end

get '/game' do
  erb :game, locals: {
    word: session[:hangman].word,
    guesses_remaining: session[:hangman].guesses_remaining,
    wrong_letters_guessed: session[:hangman].wrong_letters_guessed,
    hidden_word: session[:hangman].hidden_word
  }
end

post '/game' do
  guess = params['guessed_letter']
  session[:hangman].check_guess(guess) if session[:hangman].valid_guess?(guess)
  erb :game, locals: {
    word: session[:hangman].word,
    guesses_remaining: session[:hangman].guesses_remaining,
    wrong_letters_guessed: session[:hangman].wrong_letters_guessed,
    hidden_word: session[:hangman].hidden_word
  }
end
