class Mailer < ActionMailer::Base
  default :from => App.email_from
  default_url_options[:host] = App.host
  
  def error_notification(notice)
    @notice   = notice
    @project  = notice.err.project
    
    mail({
      :to       => @project.watchers.map(&:email),
      :subject  => "[#{@project.name}] #{@notice.err.message}"
    })
  end
  
  def deploy_notification(deploy)
    @deploy   = deploy
    @project  = deploy.project
    
    mail({
      :to       => @project.watchers.map(&:email),
      :subject  => "[#{@project.name}] Deployed to #{@deploy.environment} by #{@deploy.username}"
    })
  end
  
end