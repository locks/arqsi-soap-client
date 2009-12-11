require 'rubygems'
require 'savon'
require 'sinatra'

Savon::SOAP.version = 2
url = "http://dot.dei.isep.ipp.pt/060516/dir1/srvARQSI45.asmx?wsdl"

get '/' do
=begin
  client = Savon::Client.new url
  client.wsdl.soap_actions
=end
  "<p>P&aacute;gina do grupo 45</p>" +
  
  '<a href="servico/hello_world">Hello World</a><br />' +
  '<a href="servico/inserir_pontuacao">Inserir Pontuacao</a>'
end

get '/servico/:nome' do
  (Savon::Client.new url).send(params[:nome]).to_xml
end