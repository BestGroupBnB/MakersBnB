require "helpers/database_helpers"
require "space_entity"
require "spaces_table"

RSpec.describe SpacesTable do
  def clean_and_get_database
    DatabaseHelpers.clear_table("spaces")
    return DatabaseHelpers.test_db_connection
  end

  it "start with an empty table" do
    db = clean_and_get_database
    spaces_table = SpacesTable.new(db)
    expect(spaces_table.list).to eq([])
  end

  it "adds spaces and lists them out" do
    db = clean_and_get_database
    spaces_table = SpacesTable.new(db)
    spaces_table.add(SpaceEntity.new("Mazury", "beautiful house next to Mazury Lac", 100 , "01/01/2022", "05/01/2022"))

    spaces = spaces_table.list
    expect(spaces.length).to eq 1
    expect(spaces[0].name).to eq "Mazury"
    expect(spaces[0].description).to eq "beautiful house next to Mazury Lac"
    expect(spaces[0].price).to eq 100
    expect(spaces[0].date_from).to eq "01/01/2022"
    expect(spaces[0].date_to).to eq "05/01/2022"

  end


end