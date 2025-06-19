class PagesController < ApplicationController
  include Pagy::Backend
  before_action :set_page, only: %i[show edit update destroy]

  # GET /pages
  def index
    @pages = Page
      .all
    @q = @pages.ransack(params[:q])
    @q.sorts = "id asc" if @q.sorts.empty?
    @pagy, @pages = pagy(@q.result, page: params[:page], items: params[:items])
  end

  # GET /pages/1
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to @page, notice: t("controller.create.success", model: Page.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pages/1
  def update
    if @page.update(page_params)
      redirect_to @page, notice: t("controller.edit.success", model: Page.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /pages/1
  def destroy
    @page.destroy!
    redirect_to pages_url, notice: t("controller.destroy.success", model: Page.model_name.human)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page
        .find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.expect(page: %w[url])
    end
end
