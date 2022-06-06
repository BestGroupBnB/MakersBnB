require "helpers/database_helpers"

RSpec.describe "Requests", type: :feature do 
  before(:each) do
    DatabaseHelpers.clear_table("users")
    DatabaseHelpers.clear_table("spaces")
    DatabaseHelpers.clear_table("dates")
    DatabaseHelpers.clear_table("requests")
    db = DatabaseHelpers.test_db_connection
    db.run("INSERT INTO users(email,password) VALUES('user1@gmail.com','password');")
    db.run("INSERT INTO users(email,password) VALUES('owner@gmail.com','password');")
    db.run("INSERT INTO users(email,password) VALUES('reques@gmail.com','password');")
end
# if reqeust empty
    it "starts with an empty request page" do
        visit "/login"
        fill_in "email", with: "user1@gmail.com"
        fill_in "password", with: "password"
        click_button "Login"
        

        click_link "Requests"   
        expect(page).to have_content "Requests"
        expect(page).to have_link("Logout")
        expect(page).to have_link("Spaces")
    end 

    it "shows the request i have made" do
        visit "/login"
        fill_in "email", with: "user1@gmail.com"
        fill_in "password", with: "password"
        click_button "Login"

        visit "/spaces"
        click_link "List a Space"
        fill_in "name", with: "Mazury"
        fill_in "description", with: "beautiful house next to Mazury Lac"
        fill_in "price", with: "100"
        fill_in "date_from", with: "2022-01-01"
        fill_in "date_to", with: "2022-01-05"
        click_button "List my Space"

        visit "/space/1"

        page.select "2022-01-02", :from => "dates"
        click_button "Book"
        
        visit "/requests"
        expect(page).to have_content "Requests"
        expect(page).to have_content "Requests I've made"
        #expect(page).to have_content "Requests I've received"
        expect(page).to have_link("Logout")
        expect(page).to have_link("Spaces")

        expect(page).to have_content "Mazury"
        expect(page).to have_content "beautiful house next to Mazury Lac"
        expect(page).to have_content 100
        expect(page).to have_content "2022-01-02"
        
    end 

    it "shows the requests i have received" do
        visit "/login"
        fill_in "email", with: "user1@gmail.com"
        fill_in "password", with: "password"
        click_button "Login"

        visit "/spaces"
        click_link "List a Space"
        fill_in "name", with: "Mazury"
        fill_in "description", with: "beautiful house next to Mazury Lac"
        fill_in "price", with: "100"
        fill_in "date_from", with: "2022-01-01"
        fill_in "date_to", with: "2022-01-05"
        click_button "List my Space"
        visit "/logout"
        
        visit "/login"
        fill_in "email", with: "reques@gmail.com"
        fill_in "password", with: "password"
        click_button "Login"
        visit "/space/1"
        page.select "2022-01-02", :from => "dates"
        click_button "Book"

        visit "/logout"

        visit "/login"
        fill_in "email", with: "user1@gmail.com"
        fill_in "password", with: "password"
        click_button "Login"

        visit "/requests"
        expect(page).to have_content "Requests"
        expect(page).to have_content "Requests I've received"

        expect(page).to have_content "Mazury"
        expect(page).to have_content "beautiful house next to Mazury Lac"
        expect(page).to have_content 100
        expect(page).to have_content "2022-01-02"

    end 
end 