require_relative '../helpers/pauseable'

class ReferenceUSATermsConditions
  include Pausable

  BASE_URL = "http://www.referenceusa.com/?".freeze

  def accept_terms_and_conditions(capy_session)
    unless capy_session.current_url == BASE_URL
      fail "Unexpected starting url #{capy_session.current_url} for terms and conditions"
    end

    # This redirection is slooooowwww
    super_long_pause

    capy_session.find_by_id("chkAgree").set(true)
    capy_session.click_link("Continue")

    brief_pause

    capy_session.current_url
  end
end
