require "space_entity"

RSpec.describe SpaceEntity do
  it "Creates without an ID" do
    space = SpaceEntity.new("Mazury", "beautiful house next to Mazury Lac", 100, "01/01/2022", "05/01/2022", 1)
    expect(space.name).to eq "Mazury"
    expect(space.description).to eq "beautiful house next to Mazury Lac"
    expect(space.price).to eq 100
    expect(space.date_from).to eq "01/01/2022"
    expect(space.date_to).to eq "05/01/2022"
    expect(space.user_id).to eq 1
  end
  it "Creates with an ID" do
    space = SpaceEntity.new("Mazury", "beautiful house next to Mazury Lac", 100, "01/01/2022", "05/01/2022", 2, 5)
    expect(space.name).to eq "Mazury"
    expect(space.description).to eq "beautiful house next to Mazury Lac"
    expect(space.price).to eq 100
    expect(space.date_from).to eq "01/01/2022"
    expect(space.date_to).to eq "05/01/2022"
    expect(space.id).to eq 5
    expect(space.user_id).to eq 2
  end
end
