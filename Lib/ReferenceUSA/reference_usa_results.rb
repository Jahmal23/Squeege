require_relative '../helpers/pauseable'


class ReferenceUSAResults
  include Pausable

  BASE_URL = "http://www.referenceusa.com/UsWhitePages/Result/".freeze
  HOME_URL = "http://www.referenceusa.com/Home/Home".freeze

  def scrape_results(capy_session)
    unless capy_session.current_url.include? BASE_URL
      puts "Unexpected starting url #{capy_session.current_url} for results page"
      puts "Likely no results were found for that name, whatever it was"
      reset_search(capy_session)
      return
    end

    handle_row_results(capy_session)
  end

  private

  def handle_row_results(capy_session, current_page = 1)
    puts "Grabbing results for page #{current_page}"

    rows = capy_session.all(:xpath, "//table[@id='tblResults']/tbody/tr")

    # write out the results
    open('results.csv', 'a') do |f|
      index = 0
      rows.each do |row|
        puts row.text unless index == 0
        f.puts result_row_to_csv(row) unless index == 0 # skip the table header row
        index += 1
      end
    end

    brief_pause

    num_pages = get_num_pages(capy_session)

    if current_page < num_pages
      puts "We are on page #{current_page} of #{num_pages}.  Advancing to next page."

      next_button = capy_session.first(:xpath, "//div[contains(@class, 'next button')]")

      if next_button
        puts "Found the 'next' button.  Clicking for next page."
        next_button.click

        brief_pause

        return handle_row_results(capy_session, current_page + 1)
      else
        puts "Could not find the 'next' button!!! Can't get rest of results!"
      end
    end

    puts "We are on page #{current_page} of #{num_pages} and apparently no more results to obtain. Finished."

    reset_search(capy_session)
  end

  def get_num_pages(capy_session)
    num_pages = 1

    page_max = capy_session.first(:xpath, "//span[contains(@class, 'data-page-max')]")

    num_pages = page_max.text.to_i unless page_max.nil?

    num_pages
  end

  def reset_search(capy_session)
    puts "Going back to main home screen"
    capy_session.visit(HOME_URL)
    long_pause
  end

  def result_row_to_csv(row)
    columns = row.all("td")

    if columns.count > 0
      # columns[0] is a checkbox
      first = columns[1].text
      last = columns[2].text
      address = columns[3].text
      city_state = columns[4].text
      zip = columns[5].text
      phone = columns[6].text

      "#{first} #{last}, #{address}, #{city_state}, #{zip}, #{phone}"
    else
      "Could not find columns for row #{row.text}"
    end


  rescue => e
    "Could not parse #{row.text} due to: #{e.message}"
  end
end