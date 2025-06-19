class OidcsController < ApplicationController
  include Pagy::Backend
  before_action :set_oidc, only: %i[show edit update destroy]

  # GET /oidcs
  def index
    @oidcs = Oidc
      .eager_load(:account)
    @q = @oidcs.ransack(params[:q])
    @q.sorts = "id asc" if @q.sorts.empty?
    @pagy, @oidcs = pagy(@q.result, page: params[:page], items: params[:items])
  end

  # GET /oidcs/1
  def show
  end

  # GET /oidcs/new
  def new
    @oidc = Oidc.new
  end

  # GET /oidcs/1/edit
  def edit
  end

  # POST /oidcs
  def create
    @oidc = Oidc.new(oidc_params)

    if @oidc.save
      redirect_to @oidc, notice: t("controller.create.success", model: Oidc.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /oidcs/1
  def update
    if @oidc.update(oidc_params)
      redirect_to @oidc, notice: t("controller.edit.success", model: Oidc.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /oidcs/1
  def destroy
    @oidc.destroy!
    redirect_to oidcs_url, notice: t("controller.destroy.success", model: Oidc.model_name.human)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_oidc
      @oidc = Oidc
        .eager_load(:account)
        .find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def oidc_params
      params.require(:oidc).permit(:issuer, :sub, :account_id)
    end
end
