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
      puts "Unexpected starting url #{capy_session.current_url} for results page. Aborting!"
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
      uniq_detail_links.each do |detail_link|

        capy_session.visit(detail_link)

        if is_detected_as_robot?(capy_session.current_url)
          puts "WE'VE BEEN BUSTED!!! ABORTING!"
          break
        end


        address_detail = TpsResultDetail.new(city,state).get_address_detail(capy_session)

        if is_valid_new_address?(address_detail)
          puts "Found #{address_detail}!"
          @found_addresses << address_detail
          f.puts format_file_entry(address_detail)
        end

        flex_pause(8)

        # `pop back from the detail view to the main list of results
        capy_session.visit(@initial_results_page)
      end
    end

    next_page_link = capy_session.find_by_id("btnNextPage") rescue nil

    if !next_page_link.nil?
      puts "End of page #{current_page} Advancing to next page."

      @initial_results_page = next_page_link[:href]
      capy_session.visit(@initial_results_page)

      flex_pause(8)

      # recursively check the next page
      handle_row_results(capy_session, current_page + 1)
    else
      puts "No next button found, all done."
      return #nothing to search, end the recursion
    end
  end

  def is_detected_as_robot?(url)
    url.include? "internalcaptcha"
  end

  def format_file_entry(address)
    "#{@name}, #{address}"
  end

  def is_valid_new_address?(address)
    true unless (address.nil? || @found_addresses.include?(address))
  end


  def reset_search(capy_session)
    puts "Going back to main home screen"
    capy_session.visit(HOME_URL)
    flex_pause(5)
  end
end