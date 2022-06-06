require "helpers/database_helpers"

RSpec.describe "Requests", type: :feature do 
  before(:each) do
    DatabaseHelpers.clear_table("users")
    DatabaseHelpers.clear_table("spaces")
    DatabaseHelpers.clear_table("dates")
    DatabaseHelpers.clear_table("requests")
    db = DatabaseHelpers.test_db_connection
    db.run("INSERT INTO users(email,password) VALUES('owner@gmail.com','password');")
    db.run("INSERT INTO users(email,password) VALUES('reques@gmail.com','password');")
    db.run("INSERT INTO users(email,password) VALUES('user1@gmail.com','password');")
    db.run("INSERT INTO spaces (name, description, price, date_from, date_to, user_id) 
    VALUES ('testspace', 'testdesc', 3, '2022-01-05', '2022-01-10',1);")
end
# if reqeust empty
    it "starts with an empty request page" do
        visit "/login"
        fill_in "email", with: "user1@gmail.com"
        fill_in "password", with: "password"
        click_button "Login"

        click_link "Requests"   
        expect(page).to have_content "Requests"
        expect(page).to have_content "Requests I've made"
        expect(page).to have_content "Requests I've received"
        expect(page).to have_link("Logout")
        expect(page).to have_link("Spaces")
    end 

    it "shows the request i have received" do
        visit "/login"
        fill_in "email", with: "user1@gmail.com"
        fill_in "password", with: "password"
        click_button "Login"

        
    end 
end 