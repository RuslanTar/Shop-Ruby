module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    mapping do
      indexes :id, type: :integer
      indexes :name, type: :string
      indexes :description, type: :text
      indexes :role, type: :integer
      indexes :email, type: :integer
    end

    def self.search(query)
      self.__elasticsearch__.search(query)
    end
  end
end
