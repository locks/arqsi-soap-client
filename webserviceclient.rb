require 'rubygems'
require 'savon'
require 'sinatra'

Savon::SOAP.version = 2

client = Savon::Client.new "http://dot.dei.isep.ipp.pt/060516/dir1/srvARQSI45.asmx?wsdl"
resposta = client.hello_world

puts "\n\n"
puts resposta

get '/' do
  resposta.to_s
end