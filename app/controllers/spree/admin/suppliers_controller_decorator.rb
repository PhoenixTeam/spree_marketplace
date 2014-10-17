Spree::Admin::SuppliersController.class_eval do

  respond_to :pdf, only: :contract

  def signup_cgv
    @object.address = Spree::Address.default unless @object.address.present?
    respond_with(@object) do |format|
      format.html { render :layout => "/spree/layouts/cgv" }
      format.js   { render :layout => false }
    end
  end

  def agree_cgv
    # @object.address = Spree::Address.default unless @object.address.present?
    @template_path = spree.contract_admin_supplier_path(@supplier, :pdf)
    respond_with(@object) do |format|
      format.html { render :layout => "/spree/layouts/cgv" }
      format.js   { render :layout => false }
    end
  end

  def confirm_cgv
    agreed = params[:agreed_cgv]

    if !(agreed.empty?)
      @supplier.agreed_cgv = true
      @supplier.update_column(:agreed_cgv, true)
      respond_with(@object) do |format|
        flash[:success] = flash_message_for(@object, :successfully_updated)
        format.html { redirect_to admin_products_path }
        format.js   { render :layout => false }
      end
    else
      respond_with(@object) do |format|
        @template_path = spree.contract_admin_supplier_path(@supplier, :pdf)
        format.html do
          flash.now[:error] = "You must accept the terms"
          render action: 'agree_cgv', layout: "/spree/layouts/cgv"
        end
      end
    end
  end

  def update_from_cgv
    invoke_callbacks(:update, :before)
    if @supplier.update_details(permitted_resource_params)
      invoke_callbacks(:update, :after)
      respond_with(@object) do |format|
        format.html { redirect_to agree_cgv_admin_supplier_path }
        format.js   { render :layout => false }
      end
    else
      invoke_callbacks(:update, :fails)
      respond_with(@object) do |format|
        format.html do
          flash.now[:error] = @object.errors.full_messages.join(", ")
          render action: 'signup_cgv', layout: "/spree/layouts/cgv"
        end
        format.js { render layout: false }
      end
    end
  end

  def contract
    load_supplier
    respond_with(@supplier) do |format|
      format.pdf do
        template = params[:template] || "suppliers/cgv"
        render :layout => false , :template => "spree/admin/#{template}.pdf.prawn"
      end
    end
  end

  private
  def load_supplier
    @supplier = Spree::Supplier.find_by_slug!(params[:id])
    authorize! action, @supplier
  end

end
