FactoryGirl.define do
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
