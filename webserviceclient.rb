require 'rubygems'
require 'savon'
require 'sinatra'

Savon::SOAP.version = 2
servico = "http://dot.dei.isep.ipp.pt/060516/dir1/srvARQSI45.asmx"

get '/' do
  client = Savon::Client.new url+"?wsdl"

  "<p>P&aacute;gina de testes dos servi&ccedil;os do grupo 45</p>" +
  "<ul>" +

  client.wsdl.soap_actions.inject("") do |res, action|
    res +
    "  <li>" + action[1].values[1] +
    "    <ul><a href='API/xml/#{action[0]}'>xml</a></ul>" +
    "    <ul><a href='API/yaml/#{action[0]}'>yaml</a></ul>" +
    "  </li>"+
    "  <br />"
  end + '</ul>'
end

get '/API/:formato/:nome' do
  (Savon::Client.new url).send(params[:nome]).send("to_"+params[:formato])
end