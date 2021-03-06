require_relative '../helpers/pauseable'

# page object that represents home page navigation
# assumes you have signed in using your library card
class ReferenceUSAHome
  include Pausable

  SEARCH_URL = "http://www.referenceusa.com/UsWhitePages/Search/Quick/".freeze
  BASE_URL = "http://www.referenceusa.com/Home/Home".freeze


  def reset_to_home_page(capy_session)
    capy_session.visit(BASE_URL)
    flex_pause(5)
  end

  # At this point we are assumed to be logged in with a valid session
  def perform_search(capy_session, first_name, last_name, city, state)

    unless capy_session.current_url == BASE_URL
      fail "Unexpected starting url #{capy_session.current_url} for home page"
    end

    capy_session.visit(SEARCH_URL)

    flex_pause(5)

    puts "Main Ref Usa search page loaded.  Filling in person info."


    capy_session.fill_in 'firstName', with: first_name
    capy_session.fill_in 'lastName', with: last_name
    capy_session.fill_in 'city', with: city
    capy_session.select(state, from: 'stateProvince')

    capy_session.click_link("View Results")

    puts "Clicked the View results button.  Waiting"

    long_pause

    capy_session.current_url
  end

end