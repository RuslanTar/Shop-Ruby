class ElasticsearchCreateIndexesJob
  include Sidekiq::Job

  def perform
    ElasticsearchCreateIndexesService.call
  end
end