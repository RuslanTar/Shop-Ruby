class UpdateCurrenciesJob
  include Sidekiq::Job

  def perform
    existed_jobs = Sidekiq::ScheduledSet.new.select { _1.klass == 'UpdateCurrenciesJob' }

    if existed_jobs.blank?
      GetCurrencyService.call
    elsif existed_jobs.any? { |job| job.at <= Time.now }
      existed_jobs.first.reschedule(1.second.from_now)
      existed_jobs[1..].map(&:delete)
    end
  end
end