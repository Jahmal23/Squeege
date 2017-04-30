require 'rspec'
require 'byebug'

require_relative '../../../Lib/ReferenceUSA/reference_usa_home'
require_relative '../../../Lib/ReferenceUSA/reference_usa_login'
require_relative '../../../Lib/ReferenceUSA/reference_usa_terms_conditions'
require_relative '../../../Lib/ReferenceUSA/reference_usa_results'
require_relative '../../../Lib/session_boss'

describe "Reference USA results page object" do
  let(:capy_sess) { SessionBoss.new.capy_session }

  it "should comb through the results" do
    login = ReferenceUSALogin.new

    login.perform_login(capy_sess, "22400011777915")

    terms_conditions = ReferenceUSATermsConditions.new

    terms_conditions.accept_terms_and_conditions(capy_sess)

    home = ReferenceUSAHome.new

    home.perform_search(capy_sess, "Oliveira", "Marietta",  "Georgia")

    results = ReferenceUSAResults.new

    results.scrape_results(capy_sess)

    # list of people

  end

end