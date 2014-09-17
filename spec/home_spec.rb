require 'spec_helper'

describe 'viewing the home page', type: :feature do
  it 'shows the home page' do
    visit '/'
    
    expect(page).to have_css('#homepagecontent')
    within '#homepagecontent' do
      expect(page).to have_content('Eat. Drink. Relax')
    end
  end

  it 'has a link to capitol hill at bottom of page' do
    skip
    visit '/'
    click_link "Capitol Hill"
    expect(page).to have_css('#clicktocall')
    within '#clicktocall' do
    expect(page).to have_content('(303) 993-8127)')
    end
  end

  it 'has a capitol hill link at top of page' do
    skip
    visit '/'
    within '#capitolhill' do
      click_link "..."
    end
    expect(page).to have_content("(303) 993-8127)")
  end

  it 'has a lodos link' do
    skip
    visit '/'
    within '#lodo' do
      click_link "..."
    end
    expect(page).to have_css('#clicktocall')
      within '#clicktocall' do
    expect(page).to have_content("(303) 993-8127)")
    end
  end

  it 'has a menus link' do
    skip
    visit '/'
    click_link "Menus"
    expect(page).to have_css(".blackheadline")
    within '.blackheadline' do
    expect(page).to have_content("WHAT'LL IT BE?")
    end
  end

  it 'has a catering link' do
    skip
    visit '/'
    click_link "Catering"
    expect(page).to have_css(".blackheadline")
    within '.blackheadline' do
    expect(page).to have_content("WE CATER EVENTS.")
    end
  end

  it 'has a locations link' do
    skip
    visit '/'
    click_link "Locations"
    expect(page).to have_css(".entry-title")
    within '.entry-title' do
    expect(page).to have_content("Locations")
    end
  end

  it 'has a gift cards link' do
    skip
    visit '/'
    click_link "Gift Cards"
    expect(page).to have_css(".entry-title")
    within '.entry-title' do
    expect(page).to have_content("Gift Cards")
    end
  end

  it 'has a contact us link' do
    skip
    visit '/'
    click_link "Contact Us"
    expect(page).to have_css(".entry-title")
    within '.entry-title' do
    expect(page).to have_content("Contact Us")
    end
  end

end
