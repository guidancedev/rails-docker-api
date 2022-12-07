
# app/controllers/author_controller.rb
class AuthorsController < ApplicationController
  before_action :find_author, only: :show
  def index
    @authors = Author.all
    logger.info "Controller logger text"
    TestWorker.perform_async("testing sidekiq message")
    
    render json: @authors
  end

  def show
    render json: @author
  end

  private

  def find_author
    @author = Author.find(params[:id])
  end
end