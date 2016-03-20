require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe GroupMailer do
  describe '#group_info_email' do
    let(:group) { create(:group, name: 'ABC') }
    let(:user_1) { create(:user, email: 'user1@user.com') }
    let(:user_2) { create(:user, email: 'user2@user.com') }
    let(:user_3) { create(:user, email: 'user3@user.com') }
    let(:date) { '2016-03-16' }
    let(:mail) { GroupMailer.group_info_email(date, group.id) }

    before do
      group.users = [user_1, user_2]
      group.save
    end

    it 'renders the subject' do
      expect(mail.subject).to eq('Weekly report of group expenses')
    end

    it 'renders the receiver email' do
      expect(mail.to).to include 'user1@user.com'
      expect(mail.to).to include 'user2@user.com'
      expect(mail.to).not_to include 'user3@user.com'
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['admin@user.com'])
    end

    it "includes group's name in email's body" do
      expect(mail.body.encoded).to match('ABC')
    end

    context 'expneses exists' do
      before { travel_to Time.parse("2016-03-18 10:10") }

      let!(:expense_1) { create(:expense, name: 'Macbook Pro', price_value: 5000, user: user_1) }
      let!(:expense_2) { create(:expense, name: 'Xperia Z3', price_value: 1600, user: user_2) }
      let!(:expense_wrong_user) { create(:expense, name: 'Bose', price_value: 440, user: user_3) }
      let!(:expense_wrong_date) { create(:expense, name: 'Apple', price_value: 2, user: user_1, created_at: Date.parse('2016-03-05')) }

      it "includes correct expenses name in email's body" do
        expect(mail.body.encoded).to match('Macbook Pro')
        expect(mail.body.encoded).to match('Xperia Z3')
        expect(mail.body.encoded).not_to match('Bose')
        expect(mail.body.encoded).not_to match('Apple')
      end

      it "includes total price in email's body" do
        expect(mail.body.encoded).to match('6600')
      end

      it "includes dates in email's body" do
        expect(mail.body.encoded).to match("2016-03-14 - 2016-03-20")
      end
    end
  end
end
