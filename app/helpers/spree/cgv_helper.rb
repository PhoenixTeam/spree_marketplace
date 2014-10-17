module Spree
  module CgvHelper

    def check_if_cgv_aggreed
      if spree_current_user and spree_current_user.supplier? and !(spree_current_user.supplier.agreed_cgv)
        # flash[:error] = "Aggree to CGV"#Spree.t('supplier_registration.already_signed_up')
        redirect_to spree.signup_cgv_admin_supplier_path(:id => spree_current_user.supplier.id) and return
      end
    end

  end
end
