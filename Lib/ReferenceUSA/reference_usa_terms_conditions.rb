require_relative '../helpers/pauseable'

class ReferenceUSATermsConditions
  include Pausable

  BASE_URL = 'http://www.referenceusa.com/?'

  def accept_terms_and_conditions(capy_session)

    raise "Unexpected starting url #{capy_session.current_url} for terms and conditions" unless capy_session.current_url == BASE_URL
    

    capy_session.find_by_id("chkAgree").set(true) rescue nil

    #capy_session.save_and_open_page

    #capy_session.check(:id => 'chkAgree')

  end


end
