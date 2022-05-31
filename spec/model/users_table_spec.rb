require 'helpers/database_helpers'
require "user_entity"
require "users_table"

RSpec.describe UsersTable do
  def clean_and_get_database
    DatabaseHelpers.clear_table("users")
    return DatabaseHelpers.test_db_connection
  end

  it "add the user and get the user" do
    db = clean_and_get_database
    user = UsersTable.new(db)
    user_id = user.add(UserEntity.new("spaceowner@gmail.com","password1","password1"))
    result = user.get(user_id)
    expect(result.email).to eql("spaceowner@gmail.com")
    expect(result.password).to eql("password1")
    expect(result.id).to eql("1")
  end

  it "prevents adding same email" do
    db = clean_and_get_database
    user = UsersTable.new(db)
    user_id = user.add(UserEntity.new("spaceowner@gmail.com","password1","password1"))
    expect(user.user_exists?("spaceowner@gmail.com")).to eq true
  end 
end
