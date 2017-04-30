require_relative '../helpers/pauseable'

class ReferenceUSALogin
  include Pausable

  BASE_URL = "http://lalibcon.state.lib.la.us/redirect.php?illcode=s1no&database=refusa".freeze
  REDIRECT_URL = "http://lalibcon.state.lib.la.us/redirect.php?illcode=s1jf&database=refusa".freeze

  def fresh_start(capy_session)
    capy_session.driver.clear_cookies
    capy_session.driver.reset!
  end

  def perform_login(capy_session, library_card_number)
    fresh_start(capy_session)

    capy_session.visit BASE_URL

    brief_pause

    capy_session.fill_in "barcode", with: ''
    capy_session.find(:xpath, "//input[@id='barcode']").set(library_card_number)

    brief_pause

    capy_session.click_button "Log In"

    long_pause

    # force a redirect to the desired page since looking
    # for the correct hyperlink proved challenging
    capy_session.visit REDIRECT_URL

    long_pause

    capy_session.current_url
  end

end