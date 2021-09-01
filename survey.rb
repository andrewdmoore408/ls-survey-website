require "sinatra"
require "sinatra/content_for"
require "tilt/erubis"


#Homepage
get "/" do
  redirect "/surveys"
end

get "/surveys" do
  erb :surveys
end

get "/surveys/new" do
  erb :new_survey
end