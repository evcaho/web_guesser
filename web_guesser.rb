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

def color(guess)
	color = case
	when guess == 0 then "white"
	when guess == @@number then "green"
	when guess < @@number - 5 || guess > @@number + 5 then "red"
	when guess < @@number && guess >= @@number -1 then "orange"
	when guess > @@number && guess <= @@number + 5 then "orange"
	end
end

get '/' do
	guess = params["guess"].to_i
	message = guess_message(guess)
	color = color(guess)
	erb :index, :locals => {:number => @@number, :color => color, :message => message}
end

