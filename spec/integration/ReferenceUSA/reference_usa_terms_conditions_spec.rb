require 'rspec'
require 'byebug'

require_relative '../../../Lib/ReferenceUSA/reference_usa_login'
require_relative '../../../Lib/ReferenceUSA/reference_usa_terms_conditions'
require_relative '../../../Lib/session_boss'

describe 'Reference USA terms and conditions object' do
  let(:capy_sess) { SessionBoss.new.capy_session }

  it 'should accept terms and conditions' do
    login = ReferenceUSALogin.new

    login.perform_login(capy_sess, '22400011777915')

    terms_conditions = ReferenceUSATermsConditions.new

    current_url = terms_conditions.accept_terms_and_conditions(capy_sess)

    byebug
    expect(current_url).to eq("http://www.referenceusa.com/Home/Home")
  end

end