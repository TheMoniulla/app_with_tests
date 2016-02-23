require 'rails_helper'

describe "the signup process", type: :feature do
  it 'signs me up when data is correct' do
    visit 'user/sign_up'
    within('#new_user') do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
    end
    expect { click_button 'Sign up' }.to change { User.count }.by 1
    expect(page).to have_content 'My expenses'
  end

  it 'show error when data is not correct' do
    visit 'user/sign_up'
    within('#new_user') do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password2'
    end
    expect { click_button 'Sign up' }.to change { User.count }.by 0
    expect(page).to have_content 'Sign up'
  end
end