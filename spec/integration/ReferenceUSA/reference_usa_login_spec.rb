require 'rspec'
require 'byebug'

require_relative '../../../Lib/ReferenceUSA/reference_usa_login'
require_relative '../../../Lib/session_boss'

describe 'Reference USA login object' do
  let(:capy_sess) { SessionBoss.new.capy_session }

  it 'should login' do
    login = ReferenceUSALogin.new

    current_url = login.perform_login(capy_sess, '22400011777915')

    expect(current_url).to eq('http://www.referenceusa.com/?')
  end

  it 'should go to the results page' do
    #home = HomePage.new
    #current_url = home.perform_search(capy_sess, 'Oliveira', '30062')

    #expect(current_url.include?('Oliveira')).to eq(true)
    #expect(current_url.include?('30062')).to eq(true)
  end

end