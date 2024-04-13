ActiveAdmin.register Api do
  permit_params :name, :url, :key_attr, :key, :action_attr, :orderid_attr, :amount_attr, :link_attr, :type_attr, :custom_comments_attr, :username

  index do
    selectable_column
    id_column
    column :name
    column :username
    column :key
    actions
  end

  filter :name
  filter :username
  filter :key

  form do |f|
    f.inputs do
      f.input :name
      f.input :username
      f.input :url
      f.input :key_attr
      f.input :key
      f.input :action_attr
      f.input :orderid_attr
      f.input :amount_attr
      f.input :link_attr
      f.input :type_attr
      f.input :custom_comments_attr
    end
    f.actions
  end

end
