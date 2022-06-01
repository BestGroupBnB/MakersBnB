require "helpers/database_helpers"
require "dates_table"
require "space_entity"
require "spaces_table"

RSpec.describe DatesTable do
  before(:each) do
    DatabaseHelpers.clear_table("spaces")
    DatabaseHelpers.clear_table("dates")
  end
  def get_database
    return DatabaseHelpers.test_db_connection
  end
  it "receive space_entry make a list of available dates" do
    db = get_database
    space_entry = SpaceEntity.new("space1","space1description",1,"2022-02-02","2022-02-06",1,1)
    dates_table = DatesTable.new(db)
    expect(dates_table.range_to_array(space_entry)).to eql(["2022-02-02","2022-02-03","2022-02-04","2022-02-05","2022-02-06"])
  end
  xit "test dates_table add method" do
    db = get_database
    space_entry = SpaceEntity.new("space1","space1description",1,"2022-02-02","2022-02-08",1,1)
    spaces_table = SpacesTable.new(db)
    spaces_table.add(space_entry)

    dates_table = DatesTable.new(db)
    result = dates_table.add(1,space_entry)
    expect(result).to eql(["1","2","3","4","5","6","7"])
  end
end
