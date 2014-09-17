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
    visit '/'
    click_link "Capitol Hill"
    expect(page).to have_css('#clicktocall')
    within '#clicktocall' do
    expect(page).to have_content('(303) 993-8127')
    end
  end

  it 'has a capitol hill link at top of page' do
    visit '/'
    expect(page).to have_css('#capitolhill')
    within '#chooselocations' do
      links = all('a')
      links[0].click
    end
     expect(page).to have_content("(303) 993-8127")
  end

  it 'has a lodos link' do
    visit '/'
      expect(page).to have_css('#capitolhill')
      within '#chooselocations' do
        links = all('a')
        links[1].click
    end
    expect(page).to have_css('#clicktocall')
      within '#clicktocall' do
    expect(page).to have_content("(303) 297-3464")
    end
  end

  it 'has a menus link' do
    visit '/'
    click_link "Menus"
    expect(page).to have_css(".blackheadline")
    within '.blackheadline' do
      expect(page.text).to match /WHAT.LL IT BE/
    end
  end

  it 'has a catering link' do
    visit '/'
    click_link "Catering"
    expect(page).to have_css(".blackheadline")
    within '.blackheadline' do
    expect(page).to have_content("We cater events")
    end
  end

  it 'has a locations link' do
    visit '/'
    click_link "Locations"
    expect(page).to have_css(".entry-title")
    within '.entry-title' do
    expect(page).to have_content("Locations")
    end
  end

  it 'has a gift cards link' do
    visit '/'
    click_link "Gift Cards"
    expect(page).to have_css(".entry-title")
    within '.entry-title' do
    expect(page).to have_content("Gift Cards")
    end
  end

  it 'has a contact us link' do
    visit '/'
    click_link "Contact Us"
    expect(page).to have_css(".entry-title")
    within '.entry-title' do
    expect(page).to have_content("Contact Us")
    end
  end

  it 'can use the nav bar from the menu page' do
    visit '/menus'
    within '.menu-main-menu-capitol-hill-container' do
      click_link "Capitol Hill"
    end
    expect(page).to have_css("#menucallout")
  end

  it 'can use the nav bar from the catering page' do
    visit '/catering'
    within '.menu-main-menu-capitol-hill-container' do
      click_link 'Menus'
    end
    expect(page).to have_css('#redcontent')
  end

  it 'can use the nav bar from the locations page' do
    visit '/locations'
    within '.menu-main-menu-capitol-hill-container' do
      click_link 'Contact Us'
    end
    expect(page).to have_css('#post-15')
  end


  it 'can use the nav bar from the contact page' do
    visit '/contact_us'
    within '.menu-main-menu-capitol-hill-container' do
      click_link 'Lodo'
    end
    expect(page).to have_css('#cateringicon')
  end

  it 'can use the nav bar to go from each location page and back' do
    visit '/capitol_hill'
    within '.menu-main-menu-capitol-hill-container' do
      click_link 'Lodo'
    end
    expect(page).to have_content("(303) 297-3464")

    within '.menu-main-menu-capitol-hill-container' do
      click_link 'Capitol Hill'
    end
    expect(page).to have_content("(303) 993-8127")
  end

  it 'can travel from either the capitol hill page to the first of the center stage links' do
    skip
    visit '/capitol_hill'
    within '#callouts' do
      links = all('a')
      links[0].click
    end
      expect(page).to have_css('')
  end

  it 'can travel from either the capitol hill page to the second of the center stage links' do
    skip
    visit '/capitol_hill'
    within '#callouts' do
      links = all('a')
      links[1].click
    end
      expect(page).to have_css('')
  end
  it 'can travel from the capitol hill page to the third of the center stage links' do
    skip
    visit '/capitol_hill'
    within '#callouts' do
      links = all('a')
      links[2].click
    end
    expect(page).to have_css('')
  end

  it 'can travel from the lodo page to one of the center stage links' do
    skip
    visit '/lodo'
    within '#callouts' do
      links = all('a')
      links[1].click
    end
    expect(page).to have_css('')
  end


  it 'can show dine-in from the menus page' do
    skip
    visit '/menus'
    within '#dinein'do
      links = all('a')
      links[0].click
    end
    expect(page).to have_css('')
  end

  it 'can show cater from the menus page' do
    skip
    visit '/menus'
    within '#catering'do
      links = all('a')
      links[0].click
    end
    expect(page).to have_css('')
  end

  it 'can show happy hour from the menus page' do
    skip
    visit '/menus'
    within '#happyhour'do
      links = all('a')
      links[0].click
    end
    expect(page).to have_css('')
  end

  it 'can travel to the capitol hill page from the maps on /locations' do
    visit '/locations'
    within '.entry-content' do
      click_link('Capitol Hill Location')
    end
    expect(page).to have_content('(303) 993-8127')
    # expect(page).to have_content('(303) 297-3464')
  end

  it 'can travel the lodo page from the maps on /locations' do
    visit '/locations'
    within '.entry-content' do
      click_link('LODO Location')
    end
    expect(page).to have_content('(303) 297-3464')
  end

  it 'can check whether you can access the admin page without logging in'
  it 'can log into the admin page using the form and access a page to change content'
  it 'can change a menu item in the admin and see it render on the menu'
  it 'can change the phone number in the db and see it render in the site'
end
