ActiveAdmin.register Tax do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :tax_type, :tax_rate #, :province_id
  #
  # or
  #w
  # permit_params do
  #   permitted = [:tax_type, :tax_rate, :province_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
