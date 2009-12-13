require 'rubygems'
require 'savon'
require 'sinatra'

def cliente
  servico = "http://dot.dei.isep.ipp.pt/060516/dir3/srvARQSI45.asmx?wsdl"
  Savon::Client.new servico
end

get '/' do
  "<p>P&aacute;gina de testes dos servi&ccedil;os do grupo 45</p>" +
  "<ol>" +
  
  cliente.wsdl.soap_actions.inject("") do |res, action|
    res +
    "  <li>" + action.to_s +
    "    <ul>" +
    "      <li><a href='API/xml/#{action}'>xml</a></li>" +
    "      <li><a href='API/yaml/#{action}'>yaml</a></li>" +
    "    </ul" +
    "  </li" +
    "  <br />"
  end +
  "</ol>"
end

get '/API/:formato/hello_world/:nome' do
  resposta = cliente.hello_world do |sapo|
    sapo.body = { :nome => params[:nome].to_s }
  end
  
  resposta.send("to_"+params[:formato])
end

get '/API/:formato/inserir_pontuacao' do
  '<form name="input" action="" method="post">
    <input type="text" name="m">mapa</input>
    <br />
    <input type="text" name="j">jogador</input>
    <br />
    <input type="text" name="r">resultado</input>
    <br />
    <input type="submit" value="submit" />
  </form>'
=begin
  resposta = cliente.inserir_pontuacao do |sapo|
    sapo.body = { :mapa => 3, :jogador => 4, :res => 1500 }
=end
  
##  redirect (resposta.soap_fault?) ? '/erro' : '/'
end

get '/teste' do
  resposta = cliente.inserir_pontuacao do |sapo|
    sapo.body = { :mapa => 50, :jogador => 50, :res => 50 }
  end
  
  if (resposta.soap_fault? == true)
    redirect '/erro'
  else
    "Operação com sucesso" +
    "<br />" +
    '<a href="/">voltar</a>'
  end
end

post '/API/:formato/inserir_pontuacao' do
  params[:m] + "<br />" +
  params[:j] + "<br />" +
  params[:r] +
=begin
  resposta = cliente.inserir_pontuacao do |sapo|
    sapo.body = {
      :mapa    => params[:m],
      :jogador => params[:j],
      :res     => params[:r]
    }
=end
  
  if (resposta.soap_fault? == true)
    redirect '/erro'
  else
    "Operação com sucesso" +
    "<br />" +
    '<a href="/">voltar</a>'
  end
end  

get '/API/:formato/:nome' do
  cliente.send(params[:nome]).send("to_"+params[:formato])
end

get '/erro' do
  "<p>Houve um erro, impossível concretizar pedido.</p>" +

  '<a href="/">voltar</a>'
end