require 'rails_helper'

describe "the signin process", type: :feature do
  before { create(:user, email: 'user@example.com', password: 'password', password_confirmation: 'password') }

  it 'signs me in when data is correct' do
    visit 'user/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'My expenses'
  end

  it 'shows error when data is not correct' do
    visit 'user/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password2'
    end
    click_button 'Log in'
    expect(page).to have_content 'Log in'
  end
end