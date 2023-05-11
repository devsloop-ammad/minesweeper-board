# frozen_string_literal: true

require 'rails_helper'

describe 'Generate board page', type: :feature do
  before do
    visit '/'
  end

  context 'when no boards are generated' do
    it 'does not recently generated boards section' do
      expect(page).to have_no_selector('h2', text: 'Recently Generated Boards')
    end

    it 'has a form to generate a new board' do
      expect(page).to have_selector('form') do |form|
        expect(form).to have_field('Name', type: 'text')
        expect(form).to have_field('Height', type: 'number')
        expect(form).to have_field('Width', type: 'number')
        expect(form).to have_field('Email', type: 'email')
        expect(form).to have_field('Mines count', type: 'number')
        expect(form).to have_css('input[required]', count: 5)
      end
    end
  end

  context 'when filling the form with valid data' do
    it 'generates a new board and takes to board details page' do
      fill_in 'Name', with: 'John Doe'
      fill_in 'Email', with: 'john.doe@example.com'
      fill_in 'Height', with: 10
      fill_in 'Width', with: 10
      fill_in 'Mines count', with: 50

      click_button 'Generate Board'

      expect(page).to have_current_path("/boards/#{Board.last.id}")

      expect(page).to have_selector('table')

      within 'table' do
        expect(page).to have_selector('td', count: 100)
        expect(page).to have_selector('td.mine', count: 50)
      end
    end
  end

  context 'when filling the form with invalid data' do
    it 'does not generate a new board' do
      fill_in 'Name', with: 'John Doe'
      fill_in 'Email', with: 'john.doe@example.com'
      fill_in 'Height', with: 10
      fill_in 'Width', with: 10
      fill_in 'Mines count', with: 101

      click_button 'Generate Board'

      expect(page).to have_content('Mines count must be less than the total number of cells')
      expect(page).not_to have_selector('table')
      expect(page).to have_current_path('/boards')
    end
  end

  context 'when boards are already present' do
    let!(:boards) { create_list(:board, 20) }

    it 'shows list of 10 recently generated boards' do
      visit '/'

      expect(page).to have_selector('h2', text: 'Recently Generated Boards')
      expect(page).to have_selector('table')

      within 'table' do
        expect(page).to have_selector('th', text: 'Name')
        expect(page).to have_selector('th', text: 'Email')
        expect(page).to have_selector('th', text: 'Created At')
      end
    end
  end
end
