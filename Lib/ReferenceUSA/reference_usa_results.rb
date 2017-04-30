require_relative '../helpers/pauseable'


class ReferenceUSAResults
  include Pausable

  BASE_URL = "http://www.referenceusa.com/UsWhitePages/Result/".freeze

  def scrape_results(capy_session)
    unless capy_session.current_url.include? BASE_URL
      fail "Unexpected starting url #{capy_session.current_url} for results page"
    end

    capy_session.within_table("tblResults") do

        capy_session.find_all("tr").each do |tr|

          byebug
            v = 5

    end

    end

  end


end