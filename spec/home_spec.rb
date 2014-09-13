require 'spec_helper'

describe 'viewing the home page', type: :feature do
  it 'shows the home page' do
    visit '/'
    within '#homepagecontent' do
      expect(page).to have_content('Eat. Drink. Relax')
    end
  end
end
