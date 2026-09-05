ActiveAdmin.register User do

  permit_params :email, :password, :password_confirmation, :role, :membership_status, :membership_paid, :membership_paid_at

  index do
    selectable_column
    id_column
    column :email
    column :role
    column :membership_status
    column :membership_paid
    column :membership_paid_at
    column :created_at
    actions
  end

  filter :email
  filter :role
  filter :membership_paid
  filter :membership_paid_at
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role, as: :select, collection: ['admin', 'member']
      f.input :membership_status
      f.input :membership_paid
      f.input :membership_paid_at, as: :datepicker
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :role
      row :membership_status
      row :membership_paid
      row :membership_paid_at
      row :created_at
      row :updated_at
    end
  end

end
