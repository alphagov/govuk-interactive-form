class ApplicationController < ActionController::Base

private

  def index_key(items_name)
    "#{items_name}-index".to_sym
  end

  def items_key(items_name)
    "#{items_name}".to_sym
  end
end
