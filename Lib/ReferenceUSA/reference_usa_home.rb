require_relative '../helpers/pauseable'

# page object that represents home page navigation
# assumes you have signed in using your library card
class ReferenceUSAHome
  include Pausable

  SEARCH_URL = "http://www.referenceusa.com/UsWhitePages/Search/Quick/"
  BASE_URL = "http://www.referenceusa.com/Home/Home"

  # At this point we are assumed to be logged in with a valid session
  def perform_search(capy_session, name, city, state)

    byebug

    unless capy_session.current_url == BASE_URL
      raise "Unexpected starting url #{capy_session.current_url} for home page"
    end

    capy_session.visit(SEARCH_URL)

    capy_session.fill_in 'lastName', with: name
    capy_session.fill_in 'city', with: city
    capy_session.select(state, from: 'stateProvince')

    form_path = "div#quickSearch"
    button_path = "//button[contains(@class, 'new-search')]"


    return capy_session.current_url




  end

end