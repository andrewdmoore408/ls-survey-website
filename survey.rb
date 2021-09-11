require "sinatra"
require "sinatra/content_for"
require "tilt/erubis"

configure do
  enable :sessions
  set :session_secret, 'secret'
end

before do
  session[:surveys] ||= []
end


get "/" do
  redirect "/surveys"
end

#Homepage//view all surveys
get "/surveys" do
  @surveys = session[:surveys]

  erb :surveys
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
    session[:success] = "The list has been created"
    redirect "/"
  else
    session[:error] = "List name must be between 1 and 100 characters"
    erb :new_survey
  end
end

#Single survey
get "/surveys/:id" do
  id = params[:id].to_i
  @survey = session[:surveys][id]
  erb :survey
end