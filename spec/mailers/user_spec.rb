require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "User Mailer" do
    let(:user) {FactoryGirl.create(:user)}
    let(:account_activation) {UserMailer.account_activation(user)}
    let(:password_reset) {UserMailer.password_reset(user)}

    context "Account Activation" do
      it "render the account_activation" do
        expect(account_activation.subject).to eq("Account Activation")
        expect(account_activation.to).to eq([user.email])
        expect(account_activation.from).to eq(["noreply@example.com"])
      end

      it "renders account_activation body" do
        expect(account_activation.body.encoded).to have_content("Welcome to the Sample App!")
      end
    end

  end
end
