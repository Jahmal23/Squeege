
# Page object that represents navigating through a list of results
class ResultsPage

  attr_accessor :results_hrefs

  # this is terrible, learn how to use xpath
  def set_results_hrefs(capy_session)

    unless capy_session.nil?

      @results_hrefs = capy_session.all(:xpath, "//a[@href]")

    end

  end

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

    cnt = 0

    if !search_term.nil? && !capy_session.nil?

      #links = capy_session.all(:xpath, "//a[contains(@href, #{search_term})]")

      links = capy_session.all('a')


      unless links.nil?

        links.each { |a| puts a[:href] }

        cnt = links.length()
      end

    end

    cnt

  end

end