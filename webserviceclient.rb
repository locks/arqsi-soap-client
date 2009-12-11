require 'rubygems'
require 'savon'
require 'sinatra'

Savon::SOAP.version = 2
url = "http://dot.dei.isep.ipp.pt/060516/dir1/srvARQSI45.asmx?wsdl"

get '/' do

  client = Savon::Client.new url
  
  "<p>P&aacute;gina de testes dos servi&ccedil;os do grupo 45</p>" + client.wsdl.soap_actions.keys.to_s +
  
  client.wsdl.soap_actions.keys.each do |key|
    key.to_s + "<br />" + "TATATATA"
  end.to_s +
=begin
=end
  '<br /><br />'+
  '<a href="servico/hello_world">Hello World</a><br />' '<a href="servico/inserir_pontuacao">Inserir Pontuacao</a>'
end

get '/servico/:nome' do
  (Savon::Client.new url).send(params[:nome]).to_xml
end