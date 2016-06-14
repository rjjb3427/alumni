class BatchesController < ApplicationController
  before_action :set_batch, only: %i(edit update register)
  before_action :set_batch_from_slug, only: %i(show signing_sheet)
  before_action :set_city, only: %i(new create)
  skip_before_action :authenticate_user!, only: %i(onboarding show)
  skip_after_action :verify_authorized, only: :onboarding

  def show
    @cover_image = @batch.cover_image.url(:large)
    @cover_image = nil unless @batch.cover_image.exists?
  end

  def new
    next_monday = Date.today + ((1 - Date.today.wday) % 7)
    @batch = @city.batches.build(starts_at: next_monday)
    @batch.price = Money.new(590000, 'EUR')
    @batch.open_for_registration = true
    authorize @batch
  end

  def create
    @batch = @city.batches.build(batch_params)
    authorize @batch
    if @batch.save
      redirect_to @batch.city
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @batch.update(batch_params)
      redirect_to city_path(@batch.city)
    else
      render :edit
    end
  end

  def onboarding
    @batches = Batch.where(onboarding: true).order(slug: :asc)
  end

  def register
    @user = current_user
  end

  def signing_sheet
    sheet = SigningSheet.new(@batch)
    send_data sheet.render,
      filename: "Batch ##{@batch.slug} - Émargement.pdf",
      type: "application/pdf",
      disposition: :inline
  end

  private

  def set_batch
    @batch = Batch.find(params[:id])
    authorize @batch
  end

  def set_batch_from_slug
    @batch = Batch.find_by_slug(params[:id])
    return render_404 if @batch.nil?
    authorize @batch
  end

  def set_city
    @city = City.find_by(slug: params[:city_id])
  end

  def batch_params
    params.require(:batch).permit(
      :starts_at,
      :time_zone,
      :price_cents,
      :price_currency,
      :open_for_registration, :last_seats, :waiting_list, :full,
      :onboarding)
  end
end
