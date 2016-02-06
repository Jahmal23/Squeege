
# Page object that represents navigating through a list of results
class ResultsPage


  def contains_exact_matches?(capy_session)

    unless capy_session.nil?

      header = capy_session.first(:xpath, "//h1[contains(@class, 'serp-results')]")

      unless header.nil?
        return (header.text.include? 'exact') && (header.text.include? 'matches')
      end

    end

    false

 end

end