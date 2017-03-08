class ReferenceUSALogin
  BASE_URL = 'http://lalibcon.state.lib.la.us/'

  def perform_login(capy_session, library_card_number)
    capy_session.visit(BASE_URL)

    form_path = "div#loginbox"
    #button_path = "//button[contains(@class, 'new-search')]"

    byebug

    # we can find the form, so let's look for the input fields within.
    capy_session.within(:css, form_path) do
      #capy_session.fill_in 'who', with: name
      #capy_session.fill_in 'where', with: zip_code

      #capy_session.find(:xpath, button_path).click

      return capy_session.current_url
    end
  end
end