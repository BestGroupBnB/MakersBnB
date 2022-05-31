require "helpers/database_helpers"

RSpec.describe "Users Feature", type: :feature do
  before(:each) do
    DatabaseHelpers.clear_table("users")
  end

  it "starts with our Sign Up homepage" do
    visit "/"
    expect(page).to have_content "Sign up to MakersBnB"
    expect(page).to have_content "Email"
    expect(page).to have_content "Password"
    expect(page).to have_content "Password Confirm"
    expect(page).to have_button "Sign Up"
    expect(page).to have_link "Login"
  end 

  it "Logging into login page" do
    visit "/"
    click_link "Login"
    expect(page).to have_link("Sign Up")
    expect(page).to have_content("Login into MakersBnB")
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_button("Login")
  end

  it "Sign up and login should display authorized" do
    visit "/"
    fill_in "Email Address", with: "space1@gmail.com"
    fill_in "Password", with: "spaceowner1"
    fill_in "Password Confirm", with: "spaceowner1"
    click_button "Sign Up"
    expect(page).to have_content("Login into MakersBnB")
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")

    fill_in "Email Address", with: "space1@gmail.com"
    fill_in "Password", with: "spaceowner1"
    click_button "Login"

    expect(page).to have_content("Authorized")

  end

end
