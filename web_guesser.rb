require 'sinatra'
require 'sinatra/reloader' if development?

@@number = 1 + rand(100)

def guess_message(guess)
	if guess == 0
		message = " "
	elsif guess > @@number + 10
		message = "way too high"
	elsif guess < @@number - 10
		message = "way too low"
	elsif guess > @@number
		message = "too high!"
	elsif guess < @@number
		message = "too low!"
	elsif guess == @@number
		message = "you guessed correctly! The number is #{@@number}"
	end
end

get '/' do
	guess = params["guess"].to_i
	message = guess_message(guess)
	erb :index, :locals => {:number => @@number, :message => message}
end

