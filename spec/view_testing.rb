require 'spec_helper'

describe 'viewing the home page' do
  it 'shows the home page' do
    visit 'url'
  expect(page).to have_text('Eat. Drink. Relax')
end
