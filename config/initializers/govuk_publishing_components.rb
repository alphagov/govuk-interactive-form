GovukPublishingComponents.configure do |c|
  c.component_guide_title = "My component guide"

  c.application_stylesheet = "custom_stylesheet" # Defaults to "application"
  c.application_print_stylesheet = "print" # Not included by default
  c.application_javascript = "custom_javascript" # Defaults to "application"
end
