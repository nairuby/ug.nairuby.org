require 'bundler/setup'
Bundler.require(:default)

configure do
  set :haml, :format => :html5

  Compass.configuration do |config|
    config.project_path = File.dirname(__FILE__)
    config.sass_dir = 'views'
  end

  set :scss, Compass.sass_engine_options
end

configure :development do
  require 'sinatra/reloader'
end

helpers do
  def file_digest(file)
    File.read("#{file}.md5")
  end
  def asset_path(file)
    "/#{file}?#{file_digest('public/' + file)}"
  end
end

# Haml file-not-found exception bubbling up from the depths.
error Errno::ENOENT do
  halt(404)
end

# 2013

get '/2013/?' do
  @title = :home
  haml :"2013/home", :layout => :"2013/layout"
end

get '/2013/:page_name' do
  page_name = params[:page_name]
  @title = page_name
  haml :"2013/#{page_name}", :layout => :"2013/layout"
end

# 2014

get '/2014/?' do
  page_name = params[:page_name]
  @title = page_name
  haml :"2014/home", :layout => :"2014/layout"
end

get '/2014/:page_name' do
  page_name = params[:page_name]
  @title = page_name
  haml :"2014/#{page_name}", :layout => :"2014/layout"
end


# 2015

get '/2015' do
  @title = :home
  @speaker = %w( keithpitty.jpg laurenvoswinkel.jpg philiparndt.jpg konstantingredeskoul.png johndalton.jpg shevauncoker.jpg seanmarcia.jpg josspaling.jpg erikmichaelsober.jpg johnbarton.jpg amywibowo.jpg
    scottfeinberg.jpg sabrinaleandro.jpg ).sample
  haml :"2015/home", :layout => :"2015/layout"
end

# 2016

get '/2017' do
  @title = :home
  @speaker = %w( keithpitty.jpg laurenvoswinkel.jpg philiparndt.jpg konstantingredeskoul.png johndalton.jpg shevauncoker.jpg seanmarcia.jpg josspaling.jpg erikmichaelsober.jpg johnbarton.jpg amywibowo.jpg
    scottfeinberg.jpg sabrinaleandro.jpg ).sample
  haml :"2017/home", :layout => :"2017/layout"
end

get '/2016' do
  @title = :home
  @speaker = %w( keithpitty.jpg laurenvoswinkel.jpg philiparndt.jpg konstantingredeskoul.png johndalton.jpg shevauncoker.jpg seanmarcia.jpg josspaling.jpg erikmichaelsober.jpg johnbarton.jpg amywibowo.jpg
    scottfeinberg.jpg sabrinaleandro.jpg ).sample
  haml :"2016/home", :layout => :"2016/layout"
end

get '/2015/:page_name' do
  page_name = params[:page_name]
  @title = page_name
  haml :"2015/#{page_name}", :layout => :"2015/layout"
end

get '/2016/:page_name' do
  page_name = params[:page_name]
  @title = page_name
  haml :"2016/#{page_name}", :layout => :"2016/layout"
end

# Generic

get '/' do
  status_code 302
  redirect '/2016'
end

post '/subscribe' do
  content_type :json

  CreateSend.api_key '64e1e3a9ca79765e3a439a2fd4588dc8'
  begin
    CreateSend::Subscriber.add "da0ee77746e2f89b40a3bdff230c415d", params[:email], "", [], true
    rescue CreateSend::BadRequest => br
      puts "Bad request error: #{br}"
      puts "Error Code:    #{br.data.Code}"
      puts "Error Message: #{br.data.Message}"
    rescue Exception => e
      puts "Error: #{e}"
  end

  {success: true}.to_json
end

# post '/talk-proposal' do
#   if params[:honeypot].empty?
#     puts '***************'
#     puts "Sending proposal from #{params[:name]} | #{params[:email]}"
#     puts '***************'
#     Pony.mail(to: 'organisers@rubyconf.org.au',
#               from: params[:email],
#               subject: "Lightning talk proposal from #{params[:name]}",
#               body: haml(:"2014/email", layout: false),
#               via: :smtp,
#               via_options: {
#                 address: 'smtp.sendgrid.net',
#                 port: '587',
#                 domain: ENV['SENDGRID_DOMAIN'],
#                 user_name: ENV['SENDGRID_USERNAME'],
#                 password: ENV['SENDGRID_PASSWORD'],
#                 authentication: :plain,
#                 enable_starttls_auto: true
#               })
#   end
#
#   { success: true }.to_json
# end

get "/:year/stylesheets/main.css" do
  content_type 'text/css', :charset => 'utf-8'
  scss :"#{params[:year]}/styles/main"
end
