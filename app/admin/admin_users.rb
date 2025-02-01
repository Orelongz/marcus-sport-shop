ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation
  actions :all, except: [:destroy]

  index do
    column "email" do |admin|
      link_to admin.email, admin_admin_user_path(admin)
    end
    column :created_at
    actions
  end

  filter :email

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
