
#page object that represents home page navigation
class Home_Page

  BASE_WHITE_PAGES_URL = "http://www.whitepages.com/"

  def perform_search(capy_session, name, zip_code)

      capy_session.visit(BASE_WHITE_PAGES_URL)

      capy_session.within(:xpath, "//form[contains(@class, 'non-mobile')]") do

        capy_session.fill_in 'who', :with => name
        capy_session.fill_in 'where', :with => zip_code

        capy_session.find(:xpath, "//button[contains(@class, 'new-search')]").click

        return capy_session.current_url

      end

  end




end