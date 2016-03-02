require 'rails_helper'

describe UserMailer do
  describe 'info_email' do
    let(:user) { create(:user, email: 'user@user.com' ) }
    let(:date) { Date.today }
    let(:mail) { UserMailer.info_email(user, date) }

    it 'renders the subject' do
      expect(mail.subject).to eq('Weekly report of your expenses')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['admin@user.com'])
    end

    it 'assigns @email' do
      expect(mail.body.encoded).to match(user.email)
    end
  end
end
