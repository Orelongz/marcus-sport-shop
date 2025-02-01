ActiveAdmin.register Product do
  menu priority: 3

  permit_params :name,
    :description,
    :product_type_id,
    :price,
    :out_of_stock,
    accessory_type_ids: [],
    url_media_files_attributes: [:id, :url, :_destroy]

  filter :name
  filter :out_of_stock
  filter :product_type

  index do
    column "name" do |product|
      link_to product.name, admin_product_path(product)
    end
    column :description
    column :product_type
    column :out_of_stock
    column :price, sortable: :price do |product|
      number_to_currency((product.price / 100), unit: "€")
    end
    actions
  end

  form do |f|
    f.inputs "Product Details" do
      f.input :name
      f.input :product_type
      f.input :out_of_stock
      f.input :description
      f.input :price
      f.input :accessory_types, as: :check_boxes
      f.inputs "Media files" do
        f.has_many :url_media_files do |t|
          t.input :url, as: :string
        end
      end
    end

    f.actions
  end

  show do
    attributes_table_for(resource) do
      row :name
      row :description
      row :product_type
      row :out_of_stock
      row :price do |product|
        number_to_currency((product.price / 100), unit: "€")
      end
      row :created_at
      row :updated_at

      row "Images" do |product|
        product.media_urls.each do |media_url|
          div do
            image_tag(media_url, {style: "width:70px; height:70px;"})
          end
        end
      end

      row "Accessories" do |product|
        if product.accessories.exists?
          ul do
            product.accessories.each do |accessory|
              li link_to accessory.name, admin_accessory_path(accessory)
            end
          end
        end
      end
    end

    active_admin_comments_for(resource)
  end
end
