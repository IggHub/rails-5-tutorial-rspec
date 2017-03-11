FactoryGirl.define do
  factory :user do
    id 1
    name "Example User"
    email "example@railstutorial.org"
    password "foobar"
    password_confirmation "foobar"
    activated true
  end
end
