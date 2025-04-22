# ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :price, :stock, :description, :category_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :price, :stock, :description, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end


  
# end
ActiveAdmin.register Product do
  config.filters = true
  filter :name
  filter :category
  filter :price

  permit_params :name, :price, :stock, :description, :category_id, :image

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :name
      f.input :price
      f.input :stock
      f.input :description
      f.input :category
      f.input :image, as: :file, hint: f.object.image.attached? ? image_tag(url_for(f.object.image), width: "100") : content_tag(:span, "No image yet")
    end

    f.actions
  end

  show do
    attributes_table do
      row :name
      row :price
      row :stock
      row :description
      row :category
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image), width: "150"
        else
          "No image"
        end
      end
    end
  end
end
