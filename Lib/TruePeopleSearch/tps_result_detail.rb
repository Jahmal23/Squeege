require_relative '../helpers/pauseable'

class TpsResultDetail
  include Pausable

  attr_reader :city
  attr_reader :state

  def initialize(city, state)
    @city = city
    @state = state
  end

  def get_address_detail(capy_session)
    address_element = capy_session.first(:xpath, './/a[@data-link-to-more="address"]')

    address = address_element.nil? ? "" : address_element.text

    is_valid_address?(address) ? address : nil
  end

  # true people search will return results from other cities!
  def is_valid_address?(address)
    address.include?(city) && address.include?(state)
  end
end