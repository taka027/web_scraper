class UserMailer < ApplicationMailer
  default from: ENV['GMAIL_ADDRESS']

  def notice(email, url, result)
    @email = email
    @url = url
    @result = result
    mail(to: email, subject: 'スクレイピングが完了しました。')
  end
end
