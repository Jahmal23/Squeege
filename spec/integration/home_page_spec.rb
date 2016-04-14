require 'rspec'
require_relative '../../Lib/home_page'
require_relative '../../Lib/session_boss'

describe 'White pages home page object' do

  let(:capy_sess) { SessionBoss.new.capy_session }

  it 'should perform a basic search' do

    home = HomePage.new
    current_url = home.perform_search(capy_sess,'Oliveira','30062')

    expect(current_url.nil?).to eq(false)
    expect(current_url.include? 'Oliveira').to eq(true)
    expect(current_url.include? '30062').to eq(true)

  end

  it 'should go to the results page' do

    home = HomePage.new
    current_url = home.perform_search(capy_sess,'Oliveira','30062')


    expect(current_url.include? 'Oliveira').to eq(true)
    expect(current_url.include? '30062').to eq(true)

  end

end