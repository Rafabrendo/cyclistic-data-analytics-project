# Estudo de Caso
<img></img>
## Análise de dados sobre como os ciclistas casuais e os membros anuais utilizam as bicicletas da Cyclistic de forma diferente

Autor: Rafael Brendo <br>
Apresentação em modo Storytelling

## Índice
[Introdução](#introdução) <br>
[Cenário](#cenário) <br>
<a href="#partes_interessadas">Partes Interessadas</a><br>
[Dados](#dados) <br>
<a href="#processamento">Processamento e Limpeza</a><br>
<a href="#tarefa">Tarefa de Negócios</a><br>
<a href="#ferramentas">Ferramentas Utilizadas</a><br>




## Introdução:
Este estudo de caso foi elaborado pela Google em parceria com a Coursera, como projeto final para obtenção do Certificado Profissional Google Data Analytics. O cenário consiste na analise de dados da Cyclistic para entendimento e, posteriormente, a obtenção de fortes insights.

A Cyclistic é um programa de compartilhamento de bicicletas com mais de 5.800 bicicletas e mais de 600 estações espalhados em Chicago, cidade localizada ao nordeste de Illinois, nos EUA. Neste contexto, o diretor de marketing acredita que o sucesso do futuro da empresa depende da maximização dos números de planos anuais contratados. Portanto, a equipe quer entender como os ciclistas casuais e os membros anuais usam as bicicletas da Cyclistic de forma diferente 

## Cenário:
Eu sou um analista de dados júnior que trabalha na equipe de analistas de marketing da Cyclistic, uma empresa de compartilhamento de bicicletas em Chicago. O diretor de marketing acredita que o sucesso futuro da empresa depende da maximização do número de planos anuais contratados. A partir desses insights, sua equipe criará uma nova estratégia de marketing para converter passageiros casuais em membros anuais. Mas, primeiro, os executivos da Cyclistic devem aprovar suas recomendações que, portanto, devem ser apoiadas com insights de dados  convincentes e visualizações de dados profissionais.

<h2 id="partes_interessadas"> Personagens e Partes Interessadas:</h2>
<ul>
    <li><strong>Cyclistic:</strong> Um programa de compartilhamento de bicicletas que conta com mais de 5.800 bicicletas e 600 estações de compartilhamento. A Cyclistic se diferencia por também oferecer bicicletas reclináveis, triciclos manuais e bicicletas de carga, tornando o compartilhamento de bicicletas mais inclusivo
    <li><strong>Lily Moreno:</strong> Diretora de marketing e sua gerente. Lily é responsável pelo desenvolvimento de campanhas e iniciativas de proomoção do programa de compartilhamento de bicicletas. As campanhas podem incluir e-mail, mídias sociais e outros canais.
    <li><strong>Equipe de análise de marketing da Cyclistic:</strong> Uma equipe de analistas de dados responsáveis por coletar, analisar e relatar dados que ajudam a orientar a estratégia de marketiing da Cyclistic.
    <li><strong>Equipe executiva da Cyclistic:</strong> A equipe executiva notoriamente detalhista decidirá se aprova o programa de marketing recomendado,
</ul>

## Dados
<ul>
    <li><b>Fonte de dados:</b> Os dados foram disponibilizados pela Motivate International Inc. sob esta <a href="https://divvybikes.com/data-license-agreement">licença</a>
    <li><a href="https://divvy-tripdata.s3.amazonaws.com/index.html">Dados históricos</a> de viagens de ciclistas (de 04/2020 - 04/2021) disponíveis em no formato .csv.
    <li>O conjunto de dados possui registros individuais de uso de bicicletas compartilháveis que constam de 13 colunas e 3.826.978 linhas. 
    <li><b>Tamanho dos dados descopactados:</b> 688,7 MB

<h2 id="processamento">Processamento e Limpeza</h2>
<li>Os dados foram baixados para o HD local para manipulação e análise usando o <b>RStudio</b>
<li><a href="https://github.com/Rafabrendo/cyclistic-data-analytics-project/blob/main/cyclistic.R">Documentação e script</a>
<li><b>Quantidade de linhas iniciais:</b> 3.826.978
<li><b>Quantidade de linhas depois da limpeza:</b> 3.553.836 
<li><b>Quantidade de colunas iniciais:</b> 13 colunas
<li><b>Quantidade de colunas Finais:</b> 20 colunas
<li><b>Limpeza:</b> Foram apagados linhas com null e em branco. 
<li><b>Processamento:</b> Foram adicionadas 7 colunas (comeco_passeio, fim_passeio, duracao_passeio, hora, data, dia_semana, km_percorridos)


<h2 id="tarefa">Tarefa de Negócios</h2>
<li><p>Analisar os dados da Cyclistic, que é uma empresa de compartilhamento de bicicletas, para poder entender o comportamento dos ciclistas casuais e os membros anuais, como eles utilizam de forma diferente as bicicletas. E a partir desses insights, a equipe vai criar uma nova estrategia de marketing para converter passageiros casuais em membros anuais</p>


<h2 id="ferramentas">Ferramentas Utilizadas</h2>
<li>Foi utilizado a linguagem <b>R</b> e o <b>RStudio</b> em todo o processo de limpeza, processamento e visualização dos dados, porque são ferramentas com grande facilidade de uso e manipulação.

