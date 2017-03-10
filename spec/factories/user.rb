FactoryGirl.define do
  factory :user do
    name "Iggy"
    email {"#{name.downcase()}@email.com"}
    password "password"
    password_confirmation "password"
  end
end
