ActiveAdmin.register Accessory do
  menu priority: 5

  permit_params :name,
    :description,
    :accessory_type_id,
    :out_of_stock,
    :price,
    url_media_files_attributes: [:id, :url, :_destroy],
    complementary_accessory_constraints_attributes: [:id, :complementary_accessory_id, :_destroy],
    complementary_accessory_prices_attributes: [:id, :price, :complementary_accessory_id, :_destroy]

  filter :name
  filter :out_of_stock
  filter :accessory_type

  index do
    column "name" do |accessory|
      link_to accessory.name, admin_accessory_path(accessory)
    end
    column :description
    column :accessory_type
    column :out_of_stock
    column :price, sortable: :price do |accessory|
      number_to_currency((accessory.price / 100), unit: "€")
    end
    actions
  end

  form do |f|
    f.inputs "Accessory Details" do
      f.input :name
      f.input :accessory_type, input_html: { disabled: !f.object.new_record? }
      f.input :out_of_stock
      f.input :description
      f.input :price
      f.inputs "Media files" do
        f.has_many :url_media_files do |t|
          t.input :url, as: :string
        end
      end

      unless f.object.new_record?
        accessories = Accessory.where("accessory_type_id != ?", f.object.accessory_type_id)

        f.inputs "Price Combinations" do
          f.has_many :complementary_accessory_prices do |t|
            t.input :price, as: :string
            t.input :complementary_accessory_id,
              as: :select,
              collection: accessories
          end
        end

        f.inputs "Accessory Constraint" do
          f.has_many :complementary_accessory_constraints do |t|
            t.input :complementary_accessory_id,
              as: :select,
              collection: accessories
          end
        end
      end
    end

    f.actions
  end

  show do
    attributes_table_for(resource) do
      row :name
      row :description
      row :accessory_type
      row :out_of_stock
      row :price do |accessory|
        number_to_currency((accessory.price / 100), unit: "€")
      end
      row :created_at
      row :updated_at

      row "Images" do |accessory|
        accessory.media_urls.each do |media_url|
          div do
            image_tag(media_url, {style: "width:70px; height:70px;"})
          end
        end
      end

      row "Products" do |accessory|
        if accessory.products.exists?
          ul do
            accessory.products.each do |product|
              li link_to product.name, admin_product_path(product)
            end
          end
        end
      end
    end

    active_admin_comments_for(resource)
  end
end
