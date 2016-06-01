require 'rails_helper'

RSpec.configure do |config|
  config.before(:each) {ActionMailer::Base.deliveries.clear}
end
