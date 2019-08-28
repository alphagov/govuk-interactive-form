class ItemsController < ApplicationController
  require 'csv'

  def index
    sasf
    session[:uuid] = SecureRandom.uuid
    collection_data = Rails.application.config_for(:items)[params[:items]]
    if collection_data
      @items = CSV.parse(File.read("data/#{collection_data['item_file']}"), headers: true).map { |row| row }.shuffle
      @answers = CSV.parse(File.read("data/#{collection_data['answers_file']}"), headers: true)
      @collection = params[:items]
    else
      render "not_found"
    end
  end
end
