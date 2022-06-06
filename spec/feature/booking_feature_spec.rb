require "helpers/database_helpers"

RSpec.describe "Booking Feature", type: :feature do
  before(:each) do
    # DatabaseHelpers.clear_table("spaces")
    DatabaseHelpers.clear_table("users")
    DatabaseHelpers.clear_table("spaces")
    DatabaseHelpers.clear_table("requests")
    db = DatabaseHelpers.test_db_connection
    db.run("INSERT INTO users (email, password) VALUES('user1@gmail.com','user1')")
    db.run("INSERT INTO users (email, password) VALUES('user2@gmail.com','user2')")
    db.run("INSERT INTO users (email, password) VALUES('user3@gmail.com','user3')")
    db.run("INSERT INTO users (email, password) VALUES('user4@gmail.com','user4')")

    db.run("INSERT INTO spaces (name,description,price,date_from,date_to,user_id) VALUES('space1','space1description',1,'2022-06-01','2022-06-06',1)")
    db.run("INSERT INTO spaces (name,description,price,date_from,date_to,user_id) VALUES('space2','space2description',2,'2022-06-01','2022-06-06',2)")
    db.run("INSERT INTO spaces (name,description,price,date_from,date_to,user_id) VALUES('space3','space3description',3,'2022-06-01','2022-06-06',3)")
    db.run("INSERT INTO spaces (name,description,price,date_from,date_to,user_id) VALUES('space4','space4description',4,'2022-06-01','2022-06-06',4)")
 
  end

  it "should navigate me to the booking page" do
    visit "/login"
    fill_in "email", with: "user1@gmail.com"
    fill_in "password", with: "user1"
    click_button "Login"

    expect(page).to have_content("Book a Space")
    click_link "user1_link"
    expect(page).to have_content("space1description")
  end

  xit "submit using the dropdown box on booking page" do
    visit "/login"
    fill_in "email", with: "user1@gmail.com"
    fill_in "password", with: "user1"
    click_button "Login"

    expect(page).to have_content("Book a Space")
    click_link "user1_link"
    expect(page).to have_content("space1")
    page.select "2022-06-03", from: "dates"
    click_button "Book"

  end
  
end
