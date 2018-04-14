require 'rspec'
require 'byebug'

require_relative '../../../Lib/ReferenceUSA/reference_usa_home'
require_relative '../../../Lib/ReferenceUSA/reference_usa_login'
require_relative '../../../Lib/ReferenceUSA/reference_usa_terms_conditions'
require_relative '../../../Lib/session_boss'

describe "Reference USA home page object" do
  let(:capy_sess) { SessionBoss.new.capy_session }

  it "should perform a basic search" do
    login = ReferenceUSALogin.new

    login.perform_login(capy_sess, "22400011777915")


    terms_conditions = ReferenceUSATermsConditions.new

    terms_conditions.accept_terms_and_conditions(capy_sess)

    home = ReferenceUSAHome.new

    current_url = home.perform_search(capy_sess,"", "Oliveira", "Marietta",  "Georgia")

    expect(current_url.include? "http://www.referenceusa.com/UsWhitePages/Result/" ).to be true
  end

end