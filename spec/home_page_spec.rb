require 'rspec'
require_relative '../Lib/home_page'
require_relative '../Lib/session_boss'

describe 'White pages home page object' do

  let(:capy_sess) { Session_Boss.new.capy_session }

  it 'should perform a basic search' do

    home = Home_Page.new
    current_url = home.perform_search(capy_sess,'Oliveira','30062')

    expect(current_url.nil?).to eq(false)
  end
end