require "helpers/database_helpers"

RSpec.describe "Spaces Feature", type: :feature do
  before(:each) do
    DatabaseHelpers.clear_table("spaces")
  end

  it "starts with an empty list of examples" do
    visit "/spaces"
    expect(page).to have_content "There are no spaces available."
  end

  it "adds and lists spaces" do
    visit "/spaces"
    click_link "List a Space"
    fill_in "Name", with: "Mazury"
    fill_in "Description", with: "beautiful house next to Mazury Lac"
    fill_in "Price per night (£)", with: "100"
    fill_in "Date from", with: "01012022"
    fill_in "Date to", with: "05012022"
    click_button "List my Space"
    expect(page).to have_content "Mazury"
    expect(page).to have_content "beautiful house next to Mazury Lac"
    expect(page).to have_content "100"
    expect(page).to have_content "01012022"
    expect(page).to have_content "05012022"
  end

  it "adds and lists multiple spaces" do
    visit "/spaces"
    click_link "List a Space"
    fill_in "Name", with: "Mazury"
    fill_in "Description", with: "beautiful house next to Mazury Lac"
    fill_in "Price per night (£)", with: "100"
    fill_in "Date from", with: "01012022"
    fill_in "Date to", with: "05012022"
    click_button "List my Space"

    click_link "List a Space"
    fill_in "Name", with: "London"
    fill_in "Description", with: "apartament next to the Big Ben"
    fill_in "Price per night (£)", with: "1000"
    fill_in "Date from", with: "07052022"
    fill_in "Date to", with: "12052022"
    click_button "List my Space"

    click_link "List a Space"
    fill_in "Name", with: "Reading"
    fill_in "Description", with: "small flat next to the town centre"
    fill_in "Price per night (£)", with: "200"
    fill_in "Date from", with: "04022023"
    fill_in "Date to", with: "20022023"
    click_button "List my Space"

    expect(page).to have_content "Mazury"
    expect(page).to have_content "beautiful house next to Mazury Lac"
    expect(page).to have_content "100"
    expect(page).to have_content "01012022"
    expect(page).to have_content "05012022"

    expect(page).to have_content "London"
    expect(page).to have_content "apartament next to the Big Ben"
    expect(page).to have_content "1000"
    expect(page).to have_content "07052022"
    expect(page).to have_content "12052022"

    expect(page).to have_content "Reading"
    expect(page).to have_content "small flat next to the town centre"
    expect(page).to have_content "200"
    expect(page).to have_content "04022023"
    expect(page).to have_content "20022023"
  end

  it "deletes spaces" do
    visit "/spaces"
    click_link "List a Space"
    fill_in "Name", with: "Mazury"
    fill_in "Description", with: "beautiful house next to Mazury Lac"
    fill_in "Price per night (£)", with: "100"
    fill_in "Date from", with: "01012022"
    fill_in "Date to", with: "05012022"
    click_button "List my Space"

    click_link "List a Space"
    fill_in "Name", with: "London"
    fill_in "Description", with: "apartament next to the Big Ben"
    fill_in "Price per night (£)", with: "1000"
    fill_in "Date from", with: "07052022"
    fill_in "Date to", with: "12052022"
    click_button "List my Space"

    click_link "List a Space"
    fill_in "Name", with: "Reading"
    fill_in "Description", with: "small flat next to the town centre"
    fill_in "Price per night (£)", with: "200"
    fill_in "Date from", with: "04022023"
    fill_in "Date to", with: "20022023"
    click_button "List my Space"

    click_button "Delete London"

    expect(page).to have_content "Mazury"
    expect(page).to have_content "beautiful house next to Mazury Lac"
    expect(page).to have_content "100"
    expect(page).to have_content "01012022"
    expect(page).to have_content "05012022"

    expect(page).not_to have_content "London"
    expect(page).not_to have_content "apartament next to the Big Ben"
    expect(page).not_to have_content "1000"
    expect(page).not_to have_content "07052022"
    expect(page).not_to have_content "12052022"

    expect(page).to have_content "Reading"
    expect(page).to have_content "small flat next to the town centre"
    expect(page).to have_content "200"
    expect(page).to have_content "04022023"
    expect(page).to have_content "20022023"
  end

  it "updates spaces" do
    visit "/spaces"
    click_link "List a Space"
    fill_in "Name", with: "Mazury"
    fill_in "Description", with: "beautiful house next to Mazury Lac"
    fill_in "Price per night (£)", with: "100"
    fill_in "Date from", with: "01012022"
    fill_in "Date to", with: "05012022"
    click_button "List my Space"

    click_link "List a Space"
    fill_in "Name", with: "London"
    fill_in "Description", with: "apartament next to the Big Ben"
    fill_in "Price per night (£)", with: "1000"
    fill_in "Date from", with: "07052022"
    fill_in "Date to", with: "12052022"
    click_button "List my Space"

    click_link "List a Space"
    fill_in "Name", with: "Reading"
    fill_in "Description", with: "small flat next to the town centre"
    fill_in "Price per night (£)", with: "200"
    fill_in "Date from", with: "04022023"
    fill_in "Date to", with: "20022023"
    click_button "List my Space"

    click_link "Edit London"
    fill_in "Name", with: "Oxford"
    fill_in "Description", with: "Flat next to University"
    fill_in "Price per night (£)", with: "350"
    fill_in "Date from", with: "03042022"
    fill_in "Date to", with: "07062022"
    click_button "Edit my Space"

    expect(page).to have_content "Mazury"
    expect(page).to have_content "beautiful house next to Mazury Lac"
    expect(page).to have_content "100"
    expect(page).to have_content "01012022"
    expect(page).to have_content "05012022"

    expect(page).not_to have_content "London"
    expect(page).not_to have_content "apartament next to the Big Ben"
    expect(page).not_to have_content "1000"
    expect(page).not_to have_content "07052022"
    expect(page).not_to have_content "12052022"

    expect(page).to have_content "Oxford"
    expect(page).to have_content "Flat next to University"
    expect(page).to have_content "350"
    expect(page).to have_content "03042022"
    expect(page).to have_content "07062022"

    expect(page).to have_content "Reading"
    expect(page).to have_content "small flat next to the town centre"
    expect(page).to have_content "200"
    expect(page).to have_content "04022023"
    expect(page).to have_content "20022023"
  end



end