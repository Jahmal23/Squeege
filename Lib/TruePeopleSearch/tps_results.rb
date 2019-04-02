require_relative '../helpers/pauseable'
require_relative 'tps_result_detail'


class TpsResults
  include Pausable

  BASE_URL = "https://www.truepeoplesearch.com/results?".freeze
  HOME_URL = "https://www.truepeoplesearch.com".freeze

  attr_reader :city
  attr_reader :state
  attr_reader :name

  attr_reader :initial_results_page
  attr_reader :found_addresses

  def initialize(name, city, state)
    @name = name
    @city = city
    @state = state
    @found_addresses = []
  end


  def scrape_results(capy_session)

    unless capy_session.current_url.include? BASE_URL
      puts "Unexpected starting url #{capy_session.current_url} for results page"
      # puts "Likely no results were found for that name, whatever it was"
      reset_search(capy_session)
      return
    end

    @initial_results_page = capy_session.current_url

    handle_row_results(capy_session)
  end

  private

  def handle_row_results(capy_session, current_page = 1)
    puts "Grabbing results for page #{current_page}"

    all_detail_links = capy_session.all(:xpath, './/a[@class="btn btn-success btn-lg detail-link shadow-form"]')

    uniq_detail_links = all_detail_links.map{|x| x[:href] }.compact.uniq

    # write out the results
    open('results.csv', 'a') do |f|
      index = 0
      uniq_detail_links.each do |detail_link|

        flex_pause(3)

        capy_session.visit(detail_link)

        flex_pause(3)

        address_detail = TpsResultDetail.new(city,state).get_address_detail(capy_session)

        if is_valid_new_address?(address_detail)
          puts "Found #{address_detail}!"
          @found_addresses << address_detail
          f.puts format_file_entry(address_detail)
        end

        flex_pause(3)

        # `pop back from the detail view to the main list of results
        capy_session.visit(@initial_results_page)

        index += 1
      end
    end

    flex_pause(2)

    num_pages = get_num_pages(capy_session)

    if current_page < num_pages
      puts "We are on page #{current_page} of #{num_pages}.  Advancing to next page."

      next_button = capy_session.first(:xpath, "//div[contains(@class, 'next button')]")

      if next_button
        puts "Found the 'next' button.  Clicking for next page."
        next_button.click

        flex_pause(2)

        return handle_row_results(capy_session, current_page + 1)
      else
        puts "Could not find the 'next' button!!! Can't get rest of results!"
      end
    end

    puts "We are on page #{current_page} of #{num_pages} and apparently no more results to obtain. Finished."

    reset_search(capy_session)
  end


  def format_file_entry(address)
    "#{@name}, #{address}"
  end
  def is_valid_new_address?(address)
    true unless (address.nil? || @found_addresses.include?(address))
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
    flex_pause(5)
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