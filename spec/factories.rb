FactoryGirl.define do
  factory :add_multiple_user do
    
  end
  factory :voting_period do
    year 1
    final_ballot_open false
  end
  factory :ballot_item do
    nominee "MyString"
    role "MyString"
  end
  factory :vote do
    title "MyString"
    voter_id 1
    nomination_item_id 1
  end
  factory :viewing do
    date "2016-03-24"
  end
  factory :nomination do
    user_id 1
    award_id 1
    theater_id 1
    play_id 1
    nominee "MyString"
    role "MyString"
    open false
    approved false
  end
  factory :award do
    award_name "MyString"
  end

  factory :play do
    title "MyString"
    theater_id 1
  end 

  factory :theater do
    name "MyString"
  end

  factory :user do
  end
end
