Spree::Admin::ShipmentsController.class_eval do
  
  before_filter :check_if_cgv_aggreed, :only => :index

end