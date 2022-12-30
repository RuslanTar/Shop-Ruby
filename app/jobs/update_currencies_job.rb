class UpdateCurrenciesJob
  include Sidekiq::Job

  def perform
    existed_jobs = Sidekiq::ScheduledSet.new.select { _1.klass == 'UpdateCurrenciesJob' }

    GetCurrencyService.call if existed_jobs.blank?
  end
end