Apipie.configure do |config|
  config.app_name                = "Rails5_Sql"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apipie"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"

  config.default_locale = nil
  config.namespaced_resources = true
  config.show_all_examples = 1
end
