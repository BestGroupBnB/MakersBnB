require "helpers/database_helpers"

RSpec.describe "Requests", type: :feature do 
  before(:each) do
    DatabaseHelpers.clear_table("spaces")
    end
# if reqeust empty
    it "starts with an empty request page" do
        visit "/"
        fill_in "email", with: "example@gmail.com"
        fill_in "password", with: "password1"
        fill_in "password_confirm", with: "password1"
        click_button "Sign Up"
        visit "/login"
        fill_in "email", with: "example@gmail.com"
        fill_in "password", with: "password1"
        click_button "Login"

        click_link "Requests"
        expect(page).to have_content "Requests"
        expect(page).to have_content "Requests I've made"
        expect(page).to have_content "Requests I've received"
        expect(page).to have_link("Logout")
        expect(page).to have_link("Spaces")
    end 
end 