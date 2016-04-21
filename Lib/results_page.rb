# Page object that represents navigating through a list of results
class ResultsPage
  attr_accessor :results_hrefs

  def contains_exact_matches?(capy_session)

    unless capy_session.nil?

      header = capy_session.first(:xpath, "//h1[contains(@class, 'serp-results')]")

      unless header.nil?
        return (header.text.include? 'exact') && (header.text.include? 'matches')
      end

    end

    false

  end


  def get_exact_match_links(capy_session, search_term)

    links = nil
    if !search_term.nil? && !capy_session.nil?

      links = capy_session.all(:xpath, "//a[contains(@href, #{search_term})]")

    end

   end

end