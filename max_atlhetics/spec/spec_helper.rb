
if ENV['coverage'] == 'on'
  require 'simplecov'

  SimpleCov.start 'rails' do
    minimum_coverage 100
    add_filter '/channels/'
    add_filter '/jobs/application_job.rb'
    add_filter '/mailers/application_mailer.rb'
    add_filter  '/services/application_service.rb'
    add_filter '/controllers/application_controller.rb'
    add_filter '/models/application_record.rb'
    add_filter '/helpers/'
    add_filter '/utils/'
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
