class ElasticsearchCreateIndexesService < ApplicationService
  def call
    create_indexes
  end

  private

  def create_indexes
    User.__elasticsearch__.create_index!
    Product.__elasticsearch__.create_index!
    # User.reindex(import: false)
    # Product.reindex(import: false)
  end
end
