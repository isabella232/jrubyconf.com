require 'environment'
require 'models'
require 'partials'

helpers do
  include Sinatra::Partials
  include Rack::Utils
  alias_method :h, :escape_html

  def use_ui?
    request.env['PATH_INFO'] == '/' # only on the index page
  end
end

not_found do
  erb :not_found
end

['/', '/index.html'].each do |r|
  get r do
    require 'data'
    erb :index
  end
end

get %r{^/([a-z]+)/?$} do |scene|
  # From javascripts/UI.js, look for "new Scene" "container" property
  scenes = %w(information intro speakers schedule proposals)
  if scenes.include?(scene)
    redirect '/#' + scene
  else
    404
  end
end

get '/proposals/new' do
  erb :proposals_form, :locals => { :proposal => Proposal.new }
end
