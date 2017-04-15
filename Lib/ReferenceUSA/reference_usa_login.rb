require_relative '../helpers/pauseable'

class ReferenceUSALogin
  include Pausable

  BASE_URL = 'http://lalibcon.state.lib.la.us/redirect.php?illcode=s1no&database=refusa'

  def fresh_start(capy_session)
    browser = capy_session.driver.browser
    browser.clear_cookies
  end

  def perform_login(capy_session, library_card_number)
    #fresh_start(capy_session)

    capy_session.visit BASE_URL

    brief_pause

    capy_session.fill_in 'barcode', with: ''
    capy_session.find(:xpath, "//input[@id='barcode']").set(library_card_number)

    brief_pause

    capy_session.click_button 'Log In'

    long_pause

    return capy_session.current_url
  end
end