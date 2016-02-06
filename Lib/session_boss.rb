require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  options = {
      :js_errors => false,
      :timeout => 120,
      :debug => false,
      :phantomjs_options => ['--load-images=no', '--disk-cache=false'],
      :inspector => true,
  }
  Capybara::Poltergeist::Driver.new(app, options)
end

# Manages instances of Capybara
class SessionBoss

  attr_reader :capy_session

  def initialize
    @capy_session = Capybara::Session.new(:poltergeist)
  end

end