FactoryGirl.define do
  factory :micropost do
    sequence(:content) {|n| "Lorem Ipsum Numero #{n}"}
    user
  end

end
