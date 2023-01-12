class ElasticsearchCreateIndexesService < ApplicationService
  def call
    create_indexes
  end

  private

  def create_indexes
    Product.__elasticsearch__.create_index!
    User.__elasticsearch__.create_index!
  end
end
