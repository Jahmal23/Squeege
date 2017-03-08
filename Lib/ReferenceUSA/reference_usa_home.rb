
# page object that represents home page navigation
# assumes you have signed in using your library card
class ReferenceUSAHome
  BASE_URL = 'http://www.referenceusa.com/UsWhitePages/Search/Quick/'

  def perform_search(capy_session, name, zip_code)
    capy_session.visit(BASE_URL)

    form_path = "div#quickSearch"
    button_path = "//button[contains(@class, 'new-search')]"

    # we can find the form, so let's look for the input fields within.
    capy_session.within(:css, form_path) do
      #capy_session.fill_in 'who', with: name
      #capy_session.fill_in 'where', with: zip_code

      #capy_session.find(:xpath, button_path).click

      return capy_session.current_url
    end
  end

end