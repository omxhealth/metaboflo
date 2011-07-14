class SampleMailer < ActionMailer::Base
  default :from => APP_CONFIG[:sample]['from']
  
  def finished_notification(sample)
    @sample = sample
    mail(:subject => "##{sample.id}: Your #{Sample.model_name.human.downcase} has been processed.",
         :to => sample.client.email)
  end
end
