class ItemsController < ApplicationController
  require 'csv'

  before_action :fetch_item_data
  before_action :retrieve_or_setup_session


  def start_page; end

  def index; end

private

  def fetch_item_data
    @items_name = params[:items]
    @item_data = Rails.application.config_for(:items)[@items_name]
    if @item_data.nil?
      render "not_found" && return
    end
  end

  def retrieve_or_setup_session
    if cookies[items_key(@items_name)].nil?
      cookies[items_key(@items_name)] = { value: rand(99999999999), expires: 2.weeks }
      cookies[index_key(@items_name)] = { value: 0, expires: 2.weeks }
    end

    if @item_data["source"] == "yaml"
      @items = YAML.load_file("config/items/#{@items_name}.yml")["questions"]
    elsif @item_data["source"] == "database"
      @items = Question.where(collection: @items_name).to_a
    end
    # Shuffle in a reproducible fashion so if they return with the same cookie they'll get the same order
    seed = Random.new(cookies[items_key(@items_name)].to_i)
    @items.shuffle!(random: seed)
    @index = cookies[index_key(@items_name)].to_i
  end
end
