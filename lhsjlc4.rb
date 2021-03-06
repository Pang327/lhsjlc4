#!/env/bin/ruby
# encoding: utf-8

require 'sinatra'
require 'time'

require './db.rb'

set :bind, '0.0.0.0'

get '/' do
  erb :index
end

get '/view' do
  erb :view
end

get '/publish' do
  erb :publish
end

post '/publish' do
  time_s = params[:from].to_i / 1000
  time_e = params[:to].to_i / 1000
  serial = params[:serial]

  info = [serial, time_s, time_e]

  dbMgr = DBManager.new
  dbMgr.publish info
  dbMgr.closeDB

  redirect 'view'
end
