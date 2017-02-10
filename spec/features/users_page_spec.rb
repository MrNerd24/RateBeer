require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryGirl.create :user, username: "Pekka"
  end

  describe "who has signed up" do
    it "can signin with right credentials" do

      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end


    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect {
      click_button('Create User')
    }.to change { User.count }.by(1)
  end

  describe "User ratings" do

    let! (:beer) { FactoryGirl.create :beer, name: "Testahol" }
    let! (:beer2) { FactoryGirl.create :beer, name: "Testahol the Great" }
    let! (:rating) { FactoryGirl.create :rating, user: User.first, beer: beer }
    let! (:rating2) { FactoryGirl.create :rating, user: User.first, beer: beer2 }

    it "should have number of ratings on the user page" do
      visit user_path(User.first.id)
      expect(page).to have_content "Ratings: 2"
    end

    it 'should show ratings on user page' do
      visit user_path(User.first.id)
      expect(page).to have_content "Testahol:"
      expect(page).to have_content "Testahol the Great:"
    end

    it "should delete rating from database when delete is clicked" do
      sign_in(username:"Pekka", password:"Foobar1")
      visit user_path(User.first.id)
      expect {
        page.find("ul").first("li").find("a").click
      }.to change { Rating.count }.by(-1)

    end
  end


end