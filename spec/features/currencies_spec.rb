require 'spec_helper'

describe 'Currencies' do
  before (:each) do
    login_in(create(:vendor_admin))
  end

  context 'list currencies' do
    before (:each) do
      visit currencies_path
    end
    it_should_behave_like 'all static pages', 'Listing Currencies', 'Listing Currencies'
  end

  context 'create' do
    before (:each) do
      visit new_currency_path
    end
    it 'does not create new record with invalid data' do
      expect { click_button 'Create Currency' }.not_to change(Currency, :count)
      expect(page).to have_selector('div.alert-error', text: 'The form contains 2 errors.')
    end
    it 'creates new record with valid data' do
      fill_in 'Name', with: 'Test Currency'
      fill_in 'Code', with: 'TC1'
      expect { click_button 'Create Currency' }.to change(Currency, :count).by(1)
      expect(current_path).to eq(currencies_path)
      expect(page).to have_selector('div.alert-success', text: "Currency 'Test Currency' was successfully created.")
    end
  end
  
  context 'read' do
    before (:each) do
      @currency = create(:currency)
      visit currency_path(@currency)
    end
    it_should_behave_like 'all static pages', 'Viewing Currency', 'Viewing Currency'
    it 'shows correct name' do
      expect(find_field('Name')['readonly']).to eq 'readonly'
      expect(find_field('Name').value).to eq @currency.name
    end
    it 'shows correct code' do
      expect(find_field('Code')['readonly']).to eq 'readonly'
      expect(find_field('Code').value).to eq @currency.code
    end
  end

  context 'update' do
    before (:each) do
      @currency = create(:currency)
      visit edit_currency_path(@currency)
    end
    it 'updates existing record correctly' do
      name = 'New Currency Name'
      fill_in 'Name', with: name
      expect { click_button 'Update Currency' }.not_to change(Currency, :count)
      expect(current_path).to eq(currencies_path)
      expect(page).to have_selector('div.alert-success', text: "Currency '#{name}' was successfully updated.")
    end
  end
  
end