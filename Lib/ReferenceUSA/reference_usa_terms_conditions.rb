require_relative '../helpers/pauseable'

class ReferenceUSATermsConditions
  include Pausable

  BASE_URL = 'http://www.referenceusa.com/?'

  def accept_terms_and_conditions(capy_session)
    unless capy_session.current_url == BASE_URL
      raise "Unexpected starting url #{capy_session.current_url} for terms and conditions"
    end

    # This redirection is slooooowwww
    super_long_pause

    capy_session.save_and_open_page

    capy_session.find_by_id("chkAgree").set(true)
    capy_session.click_link('Continue')

    #capy_session.check(:id => 'chkAgree')

    brief_pause

    capy_session.current_url
  end
end
