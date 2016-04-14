require 'rspec'
require_relative '../../Lib/session_boss'
require_relative '../../Lib/home_page'


describe 'Create capybara session' do

  it 'should have a valid session' do

    sess = SessionBoss.new

    expect(sess.capy_session.nil?).to eq(false)

  end

end