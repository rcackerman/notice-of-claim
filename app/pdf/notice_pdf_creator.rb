class NoticePDF < Prawn::Document

  def initialize(notice)
    super()
    @notice = notice
    text "this is the pdf"
  end

end
