require 'sinatra'
require 'sinatra/reloader' if development?

SECRET_NUMBER = 1 + rand(100)
@@number = SECRET_NUMBER
@@counter = 5

def guess_message(guess)
	if guess == 0
		message = " "
	elsif guess > @@number + 10
		message = "way too high. You have #{@@counter} guesses left"
	elsif guess < @@number - 10
		message = "way too low. You have #{@@counter} guesses left"
	elsif guess > @@number
		message = "too high! You have #{@@counter} guesses left"
	elsif guess < @@number
		message = "too low! You have #{@@counter} guesses left"
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

def guesses(guess)
	if @@counter == 1
		@@counter = 5
		@@number = 1 + rand(100)
		message = "You're out of guesses. Let's try a new number"
	else
		@@counter -= 1
		message = guess_message(guess)
	end
end

get '/' do
	guess = params["guess"].to_i
	message = guesses(guess)
	color = color(guess)
	erb :index, :locals => {:number => @@number, :color => color, :message => message}
end

