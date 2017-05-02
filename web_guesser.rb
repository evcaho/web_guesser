require 'sinatra'
require 'sinatra/reloader' if development?

SECRET_NUM = rand(101)

get '/' do 
	"The secret number is #{SECRET_NUM}!"
end
