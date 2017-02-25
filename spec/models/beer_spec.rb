require 'rails_helper'

RSpec.describe Beer, type: :model do

  describe "when creating a new beer" do
    it 'should save if name and style are correct' do
      beer = FactoryGirl.create :beer
      brewery = Brewery.create name:"Testory", year:2017
      brewery.beers << beer
      expect(beer).to be_valid
    end

    it "should not save without a name" do
      beer = Beer.create
      brewery = Brewery.create name:"Testory", year:2017
      brewery.beers << beer
      expect(beer).not_to be_valid
    end

    it "should not save without a style" do
      beer = Beer.create name:"Testahol"
      brewery = Brewery.create name:"Testory", year:2017
      brewery.beers << beer
      expect(beer).not_to be_valid
    end
  end


  
end
