class ReportJob < ApplicationJob
  queue_as :default


  def self.perform(user )
    ReportMailer.submission(user.reports ).deliver_now
  end
end
