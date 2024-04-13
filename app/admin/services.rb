ActiveAdmin.register Service do

  permit_params :description, :s_type, :service_family, :minimum, :maximum,
                :price, :unit, :factor, :power, :intercept,
                :sale, :has_note, :note, :req_method, :active, :custom_comments_flag, :api_id

  index do
    selectable_column
    id_column
    column :description
    column :minimum
    column :maximum
    column :sale
    column :note
    column :active
    column :api_id
    actions
  end

  filter :name
  filter :username
  filter :key

  form do |f|
    f.inputs do
      f.input :description
      f.input :s_type
      f.input :service_family, input_html: {class: 'form-control'}
      # f.input :service_family, as: :select, collection: Service.service_families.map{|sf| sf}, class: 'form-control'
      f.input :minimum
      f.input :maximum

      f.input :price
      f.input :unit
      f.input :factor
      f.input :power
      f.input :intercept

      f.input :sale
      f.input :note
      f.input :req_method
      # f.input :req_method, as: :select, collection: Service.req_methods.map{|rm| rmx}, class: 'form-control'
      f.input :active
      f.input :custom_comments_flag
      # f.select Api.all
      f.input :api_id, as: :select, collection: Api.all.map {|api| ["#{api.name}, #{api.username}", api.id]}, class: 'form-control'
    end
    f.actions
  end

end
