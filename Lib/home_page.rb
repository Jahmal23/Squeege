
# page object that represents home page navigation
class HomePage

  BASE_WHITE_PAGES_URL = 'http://www.whitepages.com/'.freeze

  def perform_search(capy_session, name, zip_code)
    capy_session.visit(BASE_WHITE_PAGES_URL)


    form_path = "//form[contains(@class, 'non-mobile')]"
    begin
      capy_session.find(:xpath, form_path)
    rescue
      raise Exception.new("Could not find the main search form!!")
    end

    #we can find the form, so let's look for the input fields within.
    capy_session.within(:xpath, form_path) do

      capy_session.fill_in 'who', :with => name
      capy_session.fill_in 'where', :with => zip_code

      capy_session.find(:xpath, "//button[contains(@class, 'new-search')]").click

      return capy_session.current_url

    end

  end




end