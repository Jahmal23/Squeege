require_relative '../helpers/pauseable'

# page object that represents home page navigation
class TpsHome
  include Pausable

  SEARCH_URL = "https://www.truepeoplesearch.com/".freeze

  def reset_to_home_page(capy_session)
    capy_session.visit(SEARCH_URL)
    flex_pause(5)
  end

  # At this point we are assumed to be logged in with a valid session
  def perform_search(capy_session, first_name, last_name, city, state)

    flex_pause(25)

    capy_session.visit(SEARCH_URL)

    puts "Main True People Search page loaded.  Filling in person info."

    capy_session.fill_in 'Name', with: "#{first_name} #{last_name}"

    flex_pause(5)

    capy_session.fill_in 'CityStateZip', with: "#{city}, #{state}"

    flex_pause(10)

    capy_session.click_button "btnSubmit"

    puts "Clicked the search  button.  Waiting"

    flex_pause(10)

    capy_session.current_url
  end

end