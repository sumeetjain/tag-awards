FactoryGirl.define do
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
