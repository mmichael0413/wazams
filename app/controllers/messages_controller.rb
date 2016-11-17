class MessagesController < ApplicationController

  def create
    TwilioClient.new.send_message(sanitized_phone, params[:url])
    head :no_content
  end

  def search
    offset = rand(1..10) * 10
    results = Giphy.search(search_params, { limit: 10, offset: offset })
    @results = results.map{ |r| r.original_image.url.to_s }
    respond_to do |format|
      format.js   {}
      format.json { render json: @results }
    end
  end

  private 

  def sanitized_phone
    params[:phone].gsub(/[^\d]/, '')
  end

  def search_params
    params.require(:search)
  end

end
