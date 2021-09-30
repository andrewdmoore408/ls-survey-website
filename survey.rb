require "sinatra"
require "sinatra/content_for"
require "tilt/erubis"

configure do
  enable :sessions
  set :session_secret, 'secret'
end

configure(:development) do
  require "sinatra/reloader"
  also_reload "database_persistence.rb"
end

before do
  session[:surveys] ||= []
  session[:email] ||= []
end

helpers do
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def check_email(email_address)
    ((email_address =~ VALID_EMAIL_REGEX) == 0)
  end
end

get "/" do
  redirect "/surveys"
end

#Homepage//view all surveys
get "/surveys" do
  @surveys = session[:surveys]

  if session[:email].empty?
    redirect "/email"
  end

  erb :surveys
end

#Email form
get "/email" do
  erb :email
end

post "/email" do
  email = params["email"]

  if !(check_email(email))
    erb :email
    session[:error] = "Please enter a valid email address"
  elsif session[:email].empty?
    session[:email] << params["email"]
    session[:success] = "Email added successfully"
  else
    session[:email].clear
    session[:email] << params["email"]
    session[:success] = "Email added successfully"
  end

  redirect "/"
end

#New survey form
get "/surveys/new" do
  erb :new_survey
end

#Input new survey
post "/surveys/new" do
  survey_name = params[:survey_name].strip
  if survey_name.size >= 1 && survey_name.size <= 100
    session[:surveys] << {name: survey_name}
    session[:success] = "Your survey has been created"
    redirect "/"
  else
    session[:error] = "Survey name must be between 1 and 100 characters"
    erb :new_survey
  end
end

#Single survey
get "/surveys/:id" do
  id = params[:id].to_i
  @survey = session[:surveys][id]
  erb :survey
end