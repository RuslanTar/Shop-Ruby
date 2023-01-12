# # frozen_string_literal: true
#
# ActiveAdmin.register Product do
#   # See permitted parameters documentation:
#   # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#   #
#   # Uncomment all parameters which should be permitted for assignment
#   #
#   permit_params :name, :price, :description, :comments, :user_id, images: []
#
#   index do
#     selectable_column
#     column :id
#     column :name do |product|
#       div truncate product.name
#     end
#     column :price do |product|
#       number_to_currency(product.price)
#     end
#     column :images do |product|
#       image_tag url_for(product.images.first || "everlabs_logo.jpeg"), size: '100x100'
#     end
#     column :description do |product|
#       div truncate product.description
#     end
#     column :comments
#     column :user
#     column :created_at
#     column :updated_at
#     actions
#   end
#
#   show do
#     attributes_table do
#       row :name
#       row :price do |product|
#         number_to_currency(product.price)
#       end
#       row :images do |product|
#         # WORK
#         image_tag url_for(product.images&.first), size: '200x200'
#         ul do
#           product.images.each do |image|
#             li do
#               image_tag url_for(image), size: '200x200'
#             end
#           end
#         end
#       end
#       row :description
#       row :comments
#       row :user
#       row :created_at
#       row :updated_at
#     end
#     active_admin_comments
#   end
#
#   form do |f|
#     f.semantic_errors
#     f.inputs do
#       input :user
#       input :name, locale: I18n.locale
#       input :description, locale: I18n.locale
#       input :price
#       input :images, as: :file, input_html: { multiple: true }
#       input :comments
#     end
#     f.actions
#   end
# end
