require 'rails_helper'

RSpec.describe User, type: :model do

  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "Without a proper password" do

    it "doesn't save a short password" do
      user = User.create username: "Pekka", password: "lol", password_confirmation: "lol"
      expect(user).not_to be_valid
    end

    it "doesn't save a password with only lowercase characters" do
      user = User.create username: "Pekka", password: "lollis", password_confirmation: "lollis"
      expect(user).not_to be_valid
    end

  end

  describe "with a proper password" do
    let(:user) { FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do

      user.ratings << FactoryGirl.create(:rating, user: user, score: 10)
      user.ratings << FactoryGirl.create(:rating2, user: user, score: 20)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user) { FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(user, 10)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(user, 10, 20, 15, 7, 9)
      best = create_beer_with_rating(user, 25)

      expect(user.favorite_beer).to eq(best)
    end

  end # describe User

  describe "favorite style" do

    let(:user) { FactoryGirl.create(:user) }

    it 'should have a method for determining one' do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it 'should be the only rated if only one rated' do
      beer = FactoryGirl.create(:beer, style:"Lager")
      rating = FactoryGirl.create(:rating, user:user, beer:beer, score:30)
      expect(user.favorite_style).to eq("Lager")
    end

    it 'should be on average the most rated style' do
      beer = FactoryGirl.create(:beer, style:"Lager")
      beer2 = FactoryGirl.create(:beer, style:"Lager")
      beer3 = FactoryGirl.create(:beer, style:"Pale ale")
      beer4 = FactoryGirl.create(:beer, style:"Weizen")
      rating = FactoryGirl.create(:rating, user:user, beer:beer, score:15)
      rating = FactoryGirl.create(:rating, user:user, beer:beer2, score:20)
      rating = FactoryGirl.create(:rating, user:user, beer:beer3, score:30)
      rating = FactoryGirl.create(:rating, user:user, beer:beer4, score:10)
      expect(user.favorite_style).to eq("Pale ale")
    end

  end

  def create_beers_with_ratings(user, *scores)
    scores.each do |score|
      create_beer_with_rating user, score
    end
  end

  def create_beer_with_rating(user, score)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score: score, beer: beer, user: user)
    beer
  end

end
