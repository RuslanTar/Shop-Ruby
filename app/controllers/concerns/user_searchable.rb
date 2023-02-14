module UserSearchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    mapping do
      indexes :name, type: :string
      indexes :email, type: :string
      indexes :role, type: :integer
    end

    def self.search(query)
      params = {
        query: {
          multi_match: {
            query: query,
            fields: %i[name email],
            fuzziness: '2'
            # 'prefix_length': '2'
          }
        }
      }

      __elasticsearch__.search(params)
    end

    def self.filter(role, sort_val)
      params = {
        sort: [
          if sort_val == 'name'
            {
              'name.keyword': {
                order: 'asc'
              }
            }
          else
            {
              'email.keyword': {
                order: 'asc'
              }
            }
          end
        ],
        size: 100
        # sort: [sort_val.to_sym => { order: 'asc' }]
      }

      if role != 'any'
        params[:query] = {
          bool: {
            must: {
              match: {
                role: role
              }
            }
          }
        }
      end

      __elasticsearch__.search(params)
    end
  end
end
