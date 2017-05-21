require_relative '../helpers/pauseable'


class ReferenceUSAResults
  include Pausable

  BASE_URL = "http://www.referenceusa.com/UsWhitePages/Result/".freeze

  def scrape_results(capy_session)
    unless capy_session.current_url.include? BASE_URL
      fail "Unexpected starting url #{capy_session.current_url} for results page"
    end

    grab_row_results(capy_session)
  end

  private

  def grab_row_results(capy_session)
    rows = capy_session.all(:xpath, "//table[@id='tblResults']/tbody/tr")

    index = 0
    rows.each do |row|
      puts row.text unless index == 0 # header row
      index += 1
    end

    brief_pause

    next_button = capy_session.first(:xpath, "//div[contains(@class, 'next button')]")

    if next_button
      next_button.click

      brief_pause

      return grab_row_results(capy_session)
    end
  end
end