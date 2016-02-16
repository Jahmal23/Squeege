require 'rspec'
require_relative '../../Lib/results_page'
require_relative '../../Lib/session_boss'
require_relative '../../Lib/home_page'

describe 'Exact matches tester' do

  let(:capy_sess) { SessionBoss.new.capy_session }

  it 'should find exact matches' do

    #capy_sess.visit("#{HomePage::BASE_WHITE_PAGES_URL}/name/Oliveira/30062" )

    #results = ResultsPage.new

    #expect(results.contains_exact_matches?(capy_sess)).to eq(true)

  end

  it 'should get exact matches count' do

    capy_sess.visit("#{HomePage::BASE_WHITE_PAGES_URL}/name/Oliveira/30062" )

    results = ResultsPage.new

    matched_links = results.get_exact_match_links(capy_sess,'Oliveira')

    expect(matched_links).to be > 0

  end



end