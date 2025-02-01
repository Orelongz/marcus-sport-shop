ActiveAdmin.register ProductType do
  menu priority: 2
  actions :all, except: [:destroy]

  permit_params :name

  filter :name

  index do
    column "name" do |product_type|
      link_to product_type.name, admin_product_type_path(product_type)
    end

    actions
  end
end
