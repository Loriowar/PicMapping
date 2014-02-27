class PicController < ApplicationController

  before_filter :validate_processed

  def show
    # stub
  end

  def index
    next_pic = Pic.next_unmapped_record

    # show 404 if pics is ended
    if next_pic.present?
      redirect_to next_pic
    else
      not_found
    end
  end

  def submit_coordinates
    @pic = Pic.find_by(id: params[:pic_id])

    # store coordinates in db
    Coordinate.create_from_array(params[:mapped_coordinates], params[:pic_id])

    # marck pic is processed
    @pic.is_processed = true
    @pic.save

    # redirect to next unmapped picture
    render js: "window.location = '/pic'"
  end

  # filters
  def validate_processed
    return if params[:id].blank?

    @pic = Pic.find_by(id: params[:id])
    not_found if @pic.blank? || @pic.is_processed
  end
end