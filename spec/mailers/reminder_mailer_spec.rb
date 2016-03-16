require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe ReminderMailer do
  describe 'reminder_email' do
    let!(:user) { create(:user, email: 'user@user.com') }
    let!(:shop_item_1) { create(:shop_item, name: 'Food', price_value: 22, user_id: user.id, purchased_on: '2016-03-19') }
    let!(:shop_item_2) { create(:shop_item, name: 'T-shirt', price_value: 34, user_id: user.id, purchased_on: '2016-03-19') }
    let!(:mail) { ReminderMailer.reminder_email(user) }

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['admin@user.com'])
    end

    it 'renders the subject' do
      travel_to Time.parse("2016-03-18 10:10") do
        expect(mail.subject).to eq('Expenses for 2016-03-19')
      end
    end

    it 'assigns @email' do
      expect(mail.body.encoded).to match(user.email)
    end

    it 'shop_item_for_day in body' do
      travel_to Time.parse("2016-03-18 10:10") do
        expect(mail.body.encoded).to match('Food')
        expect(mail.body.encoded).to match('T-shirt')
      end
    end
  end
end
