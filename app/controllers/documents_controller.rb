class DocumentsController < ApplicationController
  before_action :set_band, only: [:new, :create,]

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    @document.band = @band
    authorize @document
    @document.save

    redirect_to band_path(@band, tab: "documents")
  end

  private

  def set_band
    @band = Band.find(params[:band_id])
  end

  def document_params
    params.require(:document).permit(:file)
  end
end
