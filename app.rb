# These lines load Sinatra and a helper tool to reload the server
# when we have changed the file.
require 'sinatra/base'
require 'sinatra/reloader'

# You will want to require your data model class here
require "database_connection"
require "users_table"
require "user_entity"
# require "animals_table"
# require "animal_entity"

class WebApplicationServer < Sinatra::Base
  # This line allows us to send HTTP Verbs like `DELETE` using forms
  use Rack::MethodOverride

  configure :development do
    # In development mode (which you will be running) this enables the tool
    # to reload the server when your code changes
    register Sinatra::Reloader

    # In development mode, connect to the development database
    db = DatabaseConnection.new("localhost", "bestgroupbnb_dev")
    $global = { db: db }
  end

  configure :test do
    # In test mode, connect to the test database
    db = DatabaseConnection.new("localhost", "bestgroupbnb_test")
    $global = { db: db }
  end

  def users_table
    $global[:users_table] ||= UsersTable.new($global[:db])
  end

  # Start your server using `rackup`.
  # It will sit there waiting for requests. It isn't broken!

  # YOUR CODE GOES BELOW THIS LINE
  enable :sessions

  # sign up
  get "/" do 
    erb :index 
  end 

  post "/users" do
    email = params[:email] # UNIQUE
    password = params[:password]
    password_confirm = params[:password_confirm]
    user_id = users_table.add(UserEntity.new(email,password,password_confirm))
    redirect "/login"
  end

  # login
  get "/login" do
    erb :login
  end

  post "/login" do
    email = params[:email] # UNIQUE
    password = params[:password]
    user = users_table.get_password_from_email(email)
    if user.password == password
      session[:user] = user.id 
      redirect "/spaces"
    end
    return "Unauthorized" unless user.password == password # redirect "/spaces/user_id"
    # return "Authorized" # placeholders
  end

  # spaces
  get "/spaces" do 
    p "session id: #{session[:user]}"
    redirect "/login" unless session[:user]
    erb :spaces
  end

  # logout
  get "/logout" do
    session.clear
    p "session: #{session[:user]}"
    redirect "/login"
  end
end
