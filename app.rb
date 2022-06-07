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

require "request_entity"
require "requests_table"

require "dates_table"
require "request_space_entity"

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
    db = DatabaseConnection.new("localhost", "bestgroupbnb_test")
    $global = { db: db }
  end

  def users_table
    $global[:users_table] ||= UsersTable.new($global[:db])
  end

  def spaces_table
    $global[:spaces_table] ||= SpacesTable.new($global[:db])
  end

  def requests_table
    $global[:requests_table] ||= RequestTable.new($global[:db])
  end

  def dates_table
    $global[:dates_table] ||= DatesTable.new($global[:db])
  end

  enable :sessions

  # SIGNUP
  get "/" do 
    erb :index, locals: { check: true, email: "" }
  end 

  post "/users" do
    email = params[:email]
    password = params[:password]
    password_confirm = params[:password_confirm]      
    if (password == password_confirm && !users_table.user_exists?(email))
      user_id = users_table.add(UserEntity.new(email,password,password_confirm))
      redirect "/login"
    else 
      erb :index, locals: { check: false, email: email }
    end 
  end

  # LOGIN
  get "/login" do
    erb :login
  end

  post "/login" do
    email = params[:email]
    password = params[:password]
    user = users_table.get_password_from_email(email)
    if user.password == password
      session[:user] = user.id 
      # p "----------logged in user id: #{session[:user]}--------"
      redirect "/spaces"
    end
    return "Unauthorized" unless user.password == password # redirect "/spaces/user_id"
    # return "Authorized" # placeholders
  end

  # LOGOUT
  get "/logout" do
    # p "session: #{session[:user]}"
    session.clear
    redirect "/login"
  end
  
  # SPACES
  get "/spaces" do
    # redirect "/login" unless session[:user]
    spaces_entries = spaces_table.list
    erb :spaces, locals: {
      spaces_entries: spaces_entries
    }
  end

  get "/spaces/new" do
    erb :spaces_new
  end

  post "/spaces" do
    space_entry = SpaceEntity.new(params[:name], params[:description], params[:price], 
params[:date_from], params[:date_to], session[:user])
    space_id = spaces_table.add(space_entry)
    # dates table - add all available dates into database
    dates_table.add(space_id, space_entry)
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
    space_entry = SpaceEntity.new(params[:name], params[:description], params[:price], 
params[:date_from], params[:date_to], session[:user])
    spaces_table.update(space_index, space_entry)
    redirect "/spaces"
  end

  # BOOKING/DATES
  get "/space/:index" do
    space_id = params[:index]
    erb :space, locals: { space: spaces_table.get(space_id), dates: dates_table.list(space_id) }
  end

  post "/space/:index" do
    space_id = params[:index]
    booking_date = params[:dates]
    # update request table
    owner_id = spaces_table.get(space_id).user_id
    # p "----------logged in user id: #{session[:user]}--------"
    request_entity = RequestEntity.new(space_id, session[:user],owner_id,booking_date)
    requests_table.add(request_entity)
    # delete date from dates_table
    dates_table.delete(space_id,booking_date)
    redirect '/requests'
  end

  # REQUESTS
  get "/requests" do
    request_entries = requests_table.list
    user_id = session[:user]
    requests_by_user_id = requests_table.requests_i_have_made(user_id)
    requests_by_owner_id = requests_table.requests_i_have_received(user_id)
  #  SELECT * FROM requests wehere requester_id = user_id 
  #  SELECT * frpm reqeuests where owner_id = user_id 
    erb :requests, locals: {
      request_entries: request_entries, requests_by_user_id: requests_by_user_id, requests_by_owner_id: requests_by_owner_id
    }
  end 

  get "/request/:index" do
    request_entries = requests_table.list
    request_id = params[:index]
    user_id = session[:user]
    request_by_req_id = requests_table.get_request_space_entity(request_id)
    #binding.irb
    requested_by = spaces_table.get_owner_by_spaceID(request_by_req_id.sp_id)
    other_bookings = []
    request_entries.to_a.map do |request|
      if (request.booking_date == request_by_req_id.booking_date and request.requester_id != request_by_req_id.id)
        other_bookings.push(request)
      end
    end
    #binding.irb
    erb :request, locals:{
      request_by_req_id: request_by_req_id, requested_by: requested_by, other_bookings: other_bookings
    }
  end 

end
