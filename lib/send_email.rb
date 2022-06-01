require "sendgrid-ruby"
include SendGrid

def signed_up(mail)
    from = SendGrid::Email.new(email: 'shahin.sadeghi13@gmail.com')
    to = SendGrid::Email.new(email: mail)
    subject = "MakersBnB Registration"
    content = SendGrid::Content.new(type: "text/plain", value:"Your Registration was succesful.")
    mail = SendGrid::Mail.new(from,subject,to,content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._("send").post(request_body: mail.to_json)
    #puts response.status_code
    #puts response.body

end 