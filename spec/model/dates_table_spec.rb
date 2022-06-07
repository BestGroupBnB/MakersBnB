require "helpers/database_helpers"
require "dates_table"
require "space_entity"
require "spaces_table"

require "user_entity"
require "users_table"

require "request_entity"

RSpec.describe DatesTable do
  before(:each) do
    DatabaseHelpers.clear_table("users")
    DatabaseHelpers.clear_table("spaces")
    DatabaseHelpers.clear_table("dates")
    DatabaseHelpers.clear_table("requests")
  end
  def get_database
    return DatabaseHelpers.test_db_connection
  end
  it "receive space_entry make a list of available dates" do
    db = get_database
    user = UsersTable.new(db)
    user_id_one = user.add(UserEntity.new("spaceowner1@gmail.com","password1","password1",1))
    space_entry = SpaceEntity.new("space1","space1description",1,"2022-02-02","2022-02-06",1,1)
    dates_table = DatesTable.new(db)
    expect(dates_table.range_to_array(space_entry)).to eql(["2022-02-02","2022-02-03","2022-02-04","2022-02-05","2022-02-06"])
  end
  it "test dates_table add method" do
    db = get_database
    user = UsersTable.new(db)
    user_id_one = user.add(UserEntity.new("spaceowner1@gmail.com","password1","password1",1))
    space_entry = SpaceEntity.new("space1","space1description",1,"2022-02-02","2022-02-08",1,1)
    spaces_table = SpacesTable.new(db)
    spaces_table.add(space_entry)

    dates_table = DatesTable.new(db)
    result = dates_table.add(1,space_entry)
    expect(result).to eql(["1","2","3","4","5","6","7"])
  end

  it "get a list of dates from database" do
    db = get_database
    user = UsersTable.new(db)
    user_id_one = user.add(UserEntity.new("spaceowner1@gmail.com","password1","password1",1))
    user_id_two = user.add(UserEntity.new("spaceowner2@gmail.com","password2","password2",2))
    user_id_three = user.add(UserEntity.new("spaceowner3@gmail.com","password3","password3",3))
    
    space_entry_one = SpaceEntity.new("space1","space1description",1,"2022-02-02","2022-02-08",1,1)
    space_entry_two = SpaceEntity.new("space2","space2description",1,"2022-02-03","2022-02-09",2,2)
    space_entry_three = SpaceEntity.new("space3","space3description",1,"2022-02-04","2022-02-10",3,3)
    
    spaces_table = SpacesTable.new(db)
    spaces_table.add(space_entry_one)
    spaces_table.add(space_entry_two)
    spaces_table.add(space_entry_three)

    dates_table = DatesTable.new(db)
    dates_table.add(1,space_entry_one)
    # :list gives an array of dates in string format
    expect(dates_table.list(1)).to eql(["2022-02-02","2022-02-03","2022-02-04","2022-02-05","2022-02-06","2022-02-07","2022-02-08"])

  end

  it "deletes the selected date from the database" do
    db = get_database
    user = UsersTable.new(db)
    user_id_one = user.add(UserEntity.new("spaceowner1@gmail.com","password1","password1",1))
    user_id_two = user.add(UserEntity.new("spaceowner2@gmail.com","password2","password2",2))
    user_id_three = user.add(UserEntity.new("spaceowner3@gmail.com","password3","password3",3))
    
    space_entry_one = SpaceEntity.new("space1","space1description",1,"2022-02-02","2022-02-08",1,1)
    space_entry_two = SpaceEntity.new("space2","space2description",1,"2022-02-03","2022-02-09",2,2)
    space_entry_three = SpaceEntity.new("space3","space3description",1,"2022-02-04","2022-02-10",3,3)
   
    spaces_table = SpacesTable.new(db)
    spaces_table.add(space_entry_one)
    spaces_table.add(space_entry_two)
    spaces_table.add(space_entry_three)

    dates_table = DatesTable.new(db)
    dates_table.add(1,space_entry_one)

    expect(dates_table.list(1)).to eql(["2022-02-02","2022-02-03","2022-02-04","2022-02-05","2022-02-06","2022-02-07","2022-02-08"])
    dates_table.delete(1,"2022-02-03")
    expect(dates_table.list(1)).to eql(["2022-02-02","2022-02-04","2022-02-05","2022-02-06","2022-02-07","2022-02-08"])
  end
end
