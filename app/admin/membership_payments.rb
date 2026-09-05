ActiveAdmin.register MembershipPayment do
permit_params :user_id, :paid_at, :amount, :payment_status, :payment_gateway, :transaction_id, :razorpay_order_id

  index do
    selectable_column
    id_column
    column :membership
    column :payment_date
    column :amount
    column :payment_mode
    column :payment_status
    column :razorpay_payment_id
    column :razorpay_order_id
    actions
  end

  filter :membership
  filter :payment_date
  filter :payment_status
  filter :amount
  # remove this if it's causing issues:
  # filter :razorpay_order_id

  form do |f|
  f.inputs do
    f.input :user
    f.input :paid_at, as: :datepicker
    f.input :amount
    f.input :payment_gateway
    f.input :payment_status, as: :select, collection: ["pending", "paid", "failed"]
    f.input :transaction_id
    f.input :razorpay_order_id
  end
  f.actions
end
end
