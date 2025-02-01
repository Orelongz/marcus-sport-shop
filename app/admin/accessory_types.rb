ActiveAdmin.register AccessoryType do
  menu priority: 4
  actions :all, except: [:destroy]

  permit_params :name, :product_type_id

  filter :name
  filter :product_type
end
