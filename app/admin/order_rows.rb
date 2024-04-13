ActiveAdmin.register OrderRow do
  # permit_params :name, :url, :key_attr, :key, :action_attr, :orderid_attr, :amount_attr, :link_attr, :type_attr, :custom_comments_attr, :username

  index do
    selectable_column
    id_column
    column :order_code
    column :verified
    column :service do |order_row|
      order_row.service&.description
    end
    column :client do |order_row|
      order_row.client&.full_name
    end
    column :paid
    column :net
    column :payment_id
    column :transaction_id
    actions
  end

  filter :service, collection: proc {Service.all.map{|service| [service.description, service.id]}}
  filter :client, collection: proc {Client.all.map{|client| [client.full_name, client.id]}}
  # filter :username
  # filter :key

  # form do |f|
  #   f.inputs do
  #     f.input :name
  #     f.input :username
  #     f.input :url
  #     f.input :key_attr
  #     f.input :key
  #     f.input :action_attr
  #     f.input :orderid_attr
  #     f.input :amount_attr
  #     f.input :link_attr
  #     f.input :type_attr
  #     f.input :custom_comments_attr
  #   end
  #   f.actions
  # end

end
