# These lines load Sinatra and a helper tool to reload the server
# when we have changed the file.
require 'sinatra/base'
require 'sinatra/reloader'

# You will want to require your data model class here
require "database_connection"
require "users_table"
require "user_entity"

require "space_entity"
require "spaces_table"


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

  def spaces_table
    $global[:spaces_table] ||= SpacesTable.new($global[:db])
  end

  # Start your server using `rackup`.
  # It will sit there waiting for requests. It isn't broken!

  # YOUR CODE GOES BELOW THIS LINE
  enable :sessions

  # sign up
  get "/" do 
    erb :index, locals:{check: true, email:""}
  end 

  post "/users" do
    email = params[:email]
    password = params[:password]
    password_confirm = params[:password_confirm]      
    if (password == password_confirm && !users_table.user_exists?(email))
      user_id = users_table.add(UserEntity.new(email,password,password_confirm))
      redirect "/login"
    else 
      erb :index, locals:{check: false, email: email}
    end 
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

  #   spaces
  #   get "/spaces" do 
  #     p "session id: #{session[:user]}"
  #     redirect "/login" unless session[:user]
  #     erb :spaces
  #   end

  # logout
  get "/logout" do
    session.clear
    p "session: #{session[:user]}"
    redirect "/login"
  end
  
  # spaces
  get "/spaces" do
    spaces_entries = spaces_table.list
    erb :spaces, locals: {
      spaces_entries: spaces_entries
    }
   end

  get "/spaces/new" do
    erb :spaces_new
  end

  post "/spaces" do
    space_entry = SpaceEntity.new(params[:name], params[:description], params[:price], params[:date_from], params[:date_to])
    spaces_table.add(space_entry)
    redirect "/spaces"
  end

  delete "/spaces/:index" do
    spaces_table.remove(params[:index].to_i)
    redirect "/spaces"
  end

  get "/spaces/:index/edit" do
    space_index = params[:index].to_i
    erb :spaces_edit, locals: {
      index: space_index,
      space: spaces_table.get(space_index)
    }

  end

  patch "/spaces/:index" do
    space_index = params[:index]
    spaces_table.update(space_index, params[:name], params[:description], params[:price], params[:date_from], params[:date_to])
    redirect "/spaces"
  end

end
