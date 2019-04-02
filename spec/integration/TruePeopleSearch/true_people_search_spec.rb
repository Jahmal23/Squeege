require 'rspec'
require 'byebug'

require_relative '../../../Lib/TruePeopleSearch/tps_home'
require_relative '../../../Lib/TruePeopleSearch/tps_results'
require_relative '../../../Lib/helpers/searchable_names'
require_relative '../../../Lib/session_boss'

describe "True People Search Spec" do

  before do
    @capy_sess = SessionBoss.new.capy_session
    @retries_left = 10
  end

  it "should comb through the results" do

    city = "Orlando"
    state = "FL"

    home = TpsHome.new

    retrying = false

    SearchableNames.test_names.each do |name|

      if @retries_left < 0
        puts "TOO MANY ERRORS ENCOUNTERED TO CONTINUE. HOPE YOU FIGURE IT OUT."
        break
      end

      begin
        if retrying && @retries_left > 0
          puts "Trying to reset and recover...."
          home.reset_to_home_page(@capy_sess)
        end

        puts "SEARCHING #{name}"

        home.perform_search(@capy_sess, "", name, city,  state)

        TpsResults.new(name, city, state).scrape_results(@capy_sess)

        retrying = false
      rescue => e
        puts "FAILED TO SEARCH #{name} due to: #{e.message}"
        @capy_sess.save_screenshot
        @retries_left = @retries_left - 1
        retrying = true
      end
    end
  end
end