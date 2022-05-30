# These lines load Sinatra and a helper tool to reload the server
# when we have changed the file.
require 'sinatra/base'
require 'sinatra/reloader'

# You will want to require your data model class here
require "database_connection"
require "space_entity"
require "spaces_table"
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

  # def animals_table
  #   $global[:animals_table] ||= AnimalsTable.new($global[:db])
  # end

  # Start your server using `rackup`.
  # It will sit there waiting for requests. It isn't broken!

  # YOUR CODE GOES BELOW THIS LINE

# get "/spaces" do
#   advert_entries = advert.list
#   erb :advert_entry_index, locals: {
#     advert_entries: advert_entries
#   }
# end




  # ...

end


# get "/advert" do
#   advert_entries = advert.list
#   erb :advert_entry_index, locals: {
#     advert_entries: advert_entries
#   }
# end

# get "/advert/new" do
#   erb :advert_entry_new
# end

# post "/advert" do
#   advert_entry = AdvertEntryEntity.new(params[:number], params[:description])
#   advert.add(advert_entry)
#   redirect "/advert"
# end

# delete '/advert/:index' do
#   advert.remove(params[:index].to_i)
#   redirect '/advert'
# end