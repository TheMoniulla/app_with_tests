require 'rails_helper'

describe 'expenses', type: :feature do
  before do
    create(:shop, name: 'Awesome shop')
    create(:currency, name: 'PLN')
    create(:expenses_group, name: 'Great group')
  end
  let!(:user) { FactoryGirl.create(:user) }

  it 'create expense' do
    login_as(user)

    visit root_path
    click_on 'Expenses'
    click_on 'New expense'

    within('#new_expense') do
      fill_in 'Name', with: 'name'
      fill_in 'Price value', with: '12'
      fill_in 'Description', with: 'description'
      select 'PLN', from: 'Currency'
      select 'Awesome shop', from: 'Shop'
      select 'Great group', from: 'Expenses group'
    end
    expect { click_button 'Create Expense' }.to change { Expense.count }.by 1
    expect(page).to have_content 'New expense'
  end
end