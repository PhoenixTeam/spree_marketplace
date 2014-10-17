Spree::Admin::ProductsController.class_eval do

  before_filter :check_if_cgv_aggreed
  create.after :set_supplier

  private

    def set_supplier
      if try_spree_current_user.supplier?
        @object.add_supplier! spree_current_user.supplier
      end
    end

end
