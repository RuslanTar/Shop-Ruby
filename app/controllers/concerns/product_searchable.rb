module ProductSearchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    mapping do
      # indexes :id, type: :integer
      indexes :name, type: :string
      indexes :description, type: :text
      indexes :price, type: :integer
    end

    def self.search(query)
      params = {
        query: {
          multi_match: {
            query: query,
            fields: %i[name description],
            prefix_length: 2,
            fuzziness: "2"
          }
        }
      }

      __elasticsearch__.search(params)
    end

    def self.filter(price_min, price_max, sort_val)
      params = {
        query: {
          range: {
            price: {
              gte: price_min,
              lte: price_max
            }
          }
        },
        sort: [
          if sort_val == 'name'
            {
              'name.keyword': {
                order: 'asc'
              }
            }
          else
            {
              price: {
                order: 'asc'
              }
            }
          end
        ],
        size: 100
      }

      __elasticsearch__.search(params)
    end
  end
end
