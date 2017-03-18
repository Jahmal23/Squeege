require_relative '../helpers/pauseable'

class ReferenceUSALogin
  include Pausable

  BASE_URL = 'http://lalibcon.state.lib.la.us/redirect.php?illcode=s1no&database=refusa'

  def perform_login(capy_session, library_card_number)
    capy_session.visit BASE_URL

    brief_pause

    capy_session.fill_in 'barcode', with: ''
    capy_session.find(:xpath, "//input[@id='barcode']").set(library_card_number)

    brief_pause

    capy_session.click_button 'Log In'

    brief_pause

    return capy_session.current_url
  end
end