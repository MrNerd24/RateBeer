require 'rails_helper'

include Helpers

describe "When beer is created" do

  before :each do
    FactoryGirl.create :user, username:"Pekka"
    sign_in(username:"Pekka", password:"Foobar1")
    FactoryGirl.create :style
  end

  let!(:brewery) {FactoryGirl.create :brewery}

  it 'should save correctly' do
    visit new_beer_path
    fill_in("Name", with:"Testahol")
    click_button("Create Beer")

    expect(page).to have_content("Beer was successfully created.")
    expect(page).to have_content("Testahol")
  end

  it "shouldn't save correctly with blank name" do
    visit new_beer_path
    click_button("Create Beer")

    expect(page).to have_content("Name can't be blank")
  end
end