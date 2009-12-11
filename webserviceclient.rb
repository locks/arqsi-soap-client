require 'rubygems'
require 'savon'
require 'sinatra'

Savon::SOAP.version = 2
url = "http://dot.dei.isep.ipp.pt/060516/dir1/srvARQSI45.asmx?wsdl"

get '/' do
  (Savon::Client.new url).hello_world.to_s
end