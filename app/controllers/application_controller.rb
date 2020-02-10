class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["GOVUK_USERNAME"], password: ENV["GOVUK_PASSWORD"], if: -> { Rails.env == "production" }

private

  def index_key(items_name)
    "#{items_name}-index".to_sym
  end

  def items_key(items_name)
    "#{items_name}".to_sym
  end
end
