FactoryGirl.define do

  sequence :breweryName do |n|
    "Testory #{n}"
  end

  sequence :beerName do |n|
    "Testahol #{n}"
  end

  sequence :username do |n|
    n -= 1
    names = ["Pekka", "Timo", "Matti", "Juha", "Kari", "Mikko", "Antti", "Jari", "Jukka", "Markku", "Mika", "Hannu", "Heikki", "Seppo", "Janne"]
    i = n % names.count
    n = (n/names.count).floor
    if n == 0
      "#{names[i]}"
    else
      "#{names[i]} #{n+1}"
    end
  end

  sequence :score do |n|
    Random.rand(49)+1
  end

  factory :user do
    username
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :rating do
    score
    user
    beer
  end

  factory :rating2, class: Rating do
    score
    user username:"Pekka"
    beer
  end

  factory :brewery do
    name { generate(:breweryName) }
    year 2017
  end

  factory :beer do
    name { generate(:beerName) }
    style
    brewery
  end

  factory :style do
    name "Caffeinated"
    description "Has coffee in it, eww..."
  end

end