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
    spaces_table.add(SpaceEntity.new("Mazury", "beautiful house next to Mazury Lac", 100, "01/01/2022", "05/01/2022",1))

    spaces = spaces_table.list
    expect(spaces.length).to eq 1
    expect(spaces[0].name).to eq "Mazury"
    expect(spaces[0].description).to eq "beautiful house next to Mazury Lac"
    expect(spaces[0].price).to eq 100
    expect(spaces[0].date_from).to eq "01/01/2022"
    expect(spaces[0].date_to).to eq "05/01/2022"
    expect(spaces[0].user_id).to eq 1

  end

  it "removes spaces" do
    db = clean_and_get_database
    spaces_table = SpacesTable.new(db)

    space_1_id = spaces_table.add(SpaceEntity.new("Mazury", "beautiful house next to Mazury Lac", 100, "01/01/2022", "05/01/2022",1))
    space_2_id = spaces_table.add(SpaceEntity.new("London", "apartament next to the Big Ben", 1000, "07/05/2022", "12/05/2022",1))
    space_3_id = spaces_table.add(SpaceEntity.new("Reading", "small flat next to the town centre", 200, "04/02/2023", "20/02/2023",1))

    spaces_table.remove(space_2_id)

    spaces = spaces_table.list
    expect(spaces.length).to eq 2
    expect(spaces[0].name).to eq "Mazury"
    expect(spaces[0].description).to eq "beautiful house next to Mazury Lac"
    expect(spaces[0].price).to eq 100
    expect(spaces[0].date_from).to eq "01/01/2022"
    expect(spaces[0].date_to).to eq "05/01/2022"
    expect(spaces[0].user_id).to eq 1

    expect(spaces[1].name).to eq "Reading"
    expect(spaces[1].description).to eq "small flat next to the town centre"
    expect(spaces[1].price).to eq 200
    expect(spaces[1].date_from).to eq "04/02/2023"
    expect(spaces[1].date_to).to eq "20/02/2023"
    expect(spaces[1].user_id).to eq 1
  end

  it "updates spaces" do
    db = clean_and_get_database
    spaces_table = SpacesTable.new(db)

    space_1_id = spaces_table.add(SpaceEntity.new("Mazury", "beautiful house next to Mazury Lac", 100, "01/01/2022", "05/01/2022", 1))
    space_2_id = spaces_table.add(SpaceEntity.new("London", "apartament next to the Big Ben", 1000, "07/05/2022", "12/05/2022", 1))
    space_3_id = spaces_table.add(SpaceEntity.new("Reading", "small flat next to the town centre", 200, "04/02/2023", "20/02/2023", 1))
 
    new_space_entry = SpaceEntity.new("Oxford", "Flat next to University", 350, "03/04/2022", "07/06/2022", 1)
    spaces_table.update(space_2_id, new_space_entry)

    spaces = spaces_table.list
    expect(spaces.length).to eq 3
    expect(spaces[0].name).to eq "Mazury"
    expect(spaces[0].description).to eq "beautiful house next to Mazury Lac"
    expect(spaces[0].price).to eq 100
    expect(spaces[0].date_from).to eq "01/01/2022"
    expect(spaces[0].date_to).to eq "05/01/2022"
    expect(spaces[0].user_id).to eq 1

    expect(spaces[1].name).to eq "Oxford"
    expect(spaces[1].description).to eq "Flat next to University"
    expect(spaces[1].price).to eq 350
    expect(spaces[1].date_from).to eq "03/04/2022"
    expect(spaces[1].date_to).to eq "07/06/2022"
    expect(spaces[0].user_id).to eq 1

    expect(spaces[2].name).to eq "Reading"
    expect(spaces[2].description).to eq "small flat next to the town centre"
    expect(spaces[2].price).to eq 200
    expect(spaces[2].date_from).to eq "04/02/2023"
    expect(spaces[2].date_to).to eq "20/02/2023"
    expect(spaces[0].user_id).to eq 1
  end

  it "gets a single space" do
    db = clean_and_get_database
    spaces_table = SpacesTable.new(db)

    space_1_id = spaces_table.add(SpaceEntity.new("Mazury", "beautiful house next to Mazury Lac", 100, "01/01/2022", "05/01/2022",1))
    space_2_id = spaces_table.add(SpaceEntity.new("London", "apartament next to the Big Ben", 1000, "07/05/2022", "12/05/2022",1))
    space_3_id = spaces_table.add(SpaceEntity.new("Reading", "small flat next to the town centre", 200, "04/02/2023", "20/02/2023",1))

    space = spaces_table.get(space_2_id)

    expect(space.name).to eq "London"
    expect(space.description).to eq "apartament next to the Big Ben"
    expect(space.price).to eq 1000
    expect(space.date_from).to eq "07/05/2022"
    expect(space.date_to).to eq "12/05/2022"
    expect(space.user_id).to eq 1

  end

end
