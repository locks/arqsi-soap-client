require 'rubygems'
require 'savon'
require 'sinatra'

Savon::SOAP.version = 2
servico = "http://dot.dei.isep.ipp.pt/060516/dir3/srvARQSI45.asmx?wsdl"

get '/' do
  client = Savon::Client.new servico

  "<p>P&aacute;gina de testes dos servi&ccedil;os do grupo 45</p>" +
  "<ol>" +

  client.wsdl.soap_actions.inject("") do |res, action|
    res +
    "  <li>" + action[1].values[1] +
    "    <ul>" +
    "      <li><a href='API/xml/#{action[0]}'>xml</a></li>" +
    "      <li><a href='API/yaml/#{action[0]}'>yaml</a></li>" +
    "    </ul" +
    "  </li" +
    "  <br />"
  end +
  '</ol>'
end

get '/API/:formato/hello_world' do
  cliente = Savon::Client.new servico
  
  resposta = cliente.hello_world do |sapo|
    sapo.body = "<nome>ricardo</id>"
  end.send("to_"+params[:formato])
  
##  cliente.wsdl.soap_actions.to_s
end

get '/API/:formato/:nome' do
  (Savon::Client.new servico).send(params[:nome]).send("to_"+params[:formato])
end