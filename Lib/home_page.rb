
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


class Home_Page

  @@BASE_WHITE_PAGES_URL = "http://www.whitepages.com/"

  def perform_search(name, zip_code)

      session = Capybara::Session.new(:poltergeist)
      session.visit(@@BASE_WHITE_PAGES_URL)

      session.within(:xpath, "//form[contains(@class, 'non-mobile')]") do

      session.fill_in 'who', :with => name
      session.fill_in 'where', :with => zip_code

      session.find(:xpath, "//button[contains(@class, 'new-search')]").click

    end

  end




end