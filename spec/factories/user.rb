FactoryGirl.define do
  factory :user do
    id 1
    name "Iggy1"
    email "iggy1@email.com"
    password "foobar"
    password_confirmation {|u| u.password}
    activated true
    admin false
  end

  factory :user2, class: User do
    id 2
    name "Iggy2"
    email "iggy2@email.com"
    password "password"
    password_confirmation "password"
    activated true
    admin true
  end
end
