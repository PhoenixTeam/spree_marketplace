firstname = @supplier.address.firstname
lastname = @supplier.address.lastname

text Spree.t(:cgv_contract, company_name: @supplier.name, firstname: firstname, lastname: lastname)
