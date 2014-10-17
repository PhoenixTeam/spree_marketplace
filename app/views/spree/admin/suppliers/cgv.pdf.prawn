require 'prawn/layout'

@font_face = Spree::PdfGenerator::Config[:pdf_generator_font_face]

font @font_face


# Header
render :partial => "spree/admin/header"


move_down 60

render :partial => "contract"


# Footer
render :partial => "spree/admin/footer"
