class Admin::NewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_news, only: [:edit, :update, :destroy]
  layout 'backend'

  def index
    @news = News.all
    # @consults = current_user.consults.order(created_at: :desc)
    # @q = Event.ransack(params[:q])
    # @consults = @q.result.includes(:user).page(params[:page]).per(params[:per] || 6)
  end

  def new
    @news = current_user.news.new
  end

  def create
    @news = current_user.news.new(news_params)
    @news.publish! if params[:publish]

    if @news.save
      if params[:publish]
        redirect_to admin_news_index_path, notice: 'News Published Success!'
      else
        redirect_to admin_news_index_path, notice: 'Draft Save!'
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @news.update(news_params)
      case
      when params[:publish]
        @news.publish!
        redirect_to admin_news_index_path, notice: 'News Published Success!'
      when params[:unpublish]
        @news.unpublish!
        redirect_to admin_news_index_path, notice: 'News Unpublished Success!'
      else
        redirect_to admin_news_index_path, notice: 'Edit Success!'
      end
    else
      render :edit
    end
  end

  def destroy
    @news.destroy
    redirect_to admin_news_index_path, notice: 'News Destroy Success!'
  end

  private

  def find_news
    @news = current_user.news.find(params[:id])
  end

  def news_params
    params.require(:news).permit(:title, :content)
  end
end
