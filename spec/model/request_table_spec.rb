require 'helpers/database_helpers'
require "request_entity"
require "requests_table"

RSpec.describe RequestTable do
  def clean_and_get_database
    return DatabaseHelpers.test_db_connection
  end
  before(:each) do
    DatabaseHelpers.clear_table("users")
    DatabaseHelpers.clear_table("spaces")
    DatabaseHelpers.clear_table("dates")
    DatabaseHelpers.clear_table("requests")
    db = clean_and_get_database
    db.run("INSERT INTO users(id,email,password) VALUES(3,'owner@gmail.com','password');")
    db.run("INSERT INTO users(id,email,password) VALUES(2,'reques@gmail.com','password');")
    db.run("INSERT INTO users(id,email,password) VALUES(1,'user1@gmail.com','password');")
    db.run("INSERT INTO spaces (id,name, description, price, date_from, date_to, user_id) 
    VALUES (1,'testspace', 'testdesc', 3, '2022-01-05', '2022-01-10',1);")
  end

  it "adds a request to the table" do
    db = clean_and_get_database
    request = RequestTable.new(db)
    request_id = request.add(RequestEntity.new(1,2,3))
    result = request.get(request_id)
    expect(result.space_id).to eq 1
    expect(result.requester_id).to eq 2
    expect(result.owner_id).to eq 3
  end 
end
