
# app run file

require 'sinatra'
require 'httparty'
require 'sendgrid-ruby'
include SendGrid


get "/" do  
  puts ENV["sendgrid_key"]
  
erb (:index)
end

post "/contact" do
  from = Email.new(email: 'richardtrapanese@gmail.com')
  to = Email.new(email: params[:email_address])
  subject = 'Thank you for voting'
  content = Content.new(
    type: 'text/plain', 
    value: params[:comment]
  )
  
  # create mail object with from, subject, to and content
  mail = Mail.new(from, subject, to, content)
  
  # sets up the api key
  sg = SendGrid::API.new(
    api_key: ENV["sendgrid_key"]
  )
  
  # sends the email
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  
  # display http response code
  puts response.status_code
  
  # display http response body
  puts response.body
  
  # display http response headers
  puts response.headers
  

erb (:contact)
end





