require 'rspec'
require_relative '../Lib/results_page'
require_relative '../Lib/session_boss'
require_relative '../Lib/home_page'

describe 'Exact matches tester' do

  let(:capy_sess) { SessionBoss.new.capy_session }

  it 'should find exact matches' do

    capy_sess.visit("#{HomePage::BASE_WHITE_PAGES_URL}/name/Oliveira/30062" )

    results = ResultsPage.new

    results.contains_exact_matches?(capy_sess)

    expect(results.contains_exact_matches?(capy_sess)).to eq(true)

  end
end