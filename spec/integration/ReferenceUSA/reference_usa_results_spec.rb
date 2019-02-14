require 'rspec'
require 'byebug'

require_relative '../../../Lib/ReferenceUSA/reference_usa_home'
require_relative '../../../Lib/ReferenceUSA/reference_usa_login'
require_relative '../../../Lib/ReferenceUSA/reference_usa_terms_conditions'
require_relative '../../../Lib/ReferenceUSA/reference_usa_results'
require_relative '../../../Lib/helpers/searchable_names'
require_relative '../../../Lib/session_boss'

describe "Reference USA results page object" do

  before do
    @capy_sess = SessionBoss.new.capy_session
    @retries_left = 10
   end

  it "should comb through the results" do

    login = ReferenceUSALogin.new

    login.perform_login(@capy_sess, "22400008565125")

    terms_conditions = ReferenceUSATermsConditions.new

    terms_conditions.accept_terms_and_conditions(@capy_sess)

    home = ReferenceUSAHome.new

    retrying = false

    SearchableNames.portugual[425..-1].each do |name|

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

        home.perform_search(@capy_sess, "", name, "Brimfield",  "Massachusetts")

        results = ReferenceUSAResults.new

        results.scrape_results(@capy_sess)

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