library(tidyverse)
library(skimr)
library(geosphere)


#Identificando como os dados estão organizados

#Importando os dados
cyclistic_202004 <- read_csv("/home/rafael/Documentos/dados daa cyclistic/dados/202004-divvy-tripdata.csv")
cyclistic_202005 <- read_csv("/home/rafael/Documentos/dados daa cyclistic/dados/202005-divvy-tripdata.csv")
cyclistic_202006 <- read_csv("/home/rafael/Documentos/dados daa cyclistic/dados/202006-divvy-tripdata.csv")
cyclistic_202007 <- read_csv("/home/rafael/Documentos/dados daa cyclistic/dados/202007-divvy-tripdata.csv")
cyclistic_202008 <- read_csv("/home/rafael/Documentos/dados daa cyclistic/dados/202008-divvy-tripdata.csv")
cyclistic_202009 <- read_csv("/home/rafael/Documentos/dados daa cyclistic/dados/202009-divvy-tripdata.csv")
cyclistic_202010 <- read_csv("/home/rafael/Documentos/dados daa cyclistic/dados/202010-divvy-tripdata.csv")
cyclistic_202011 <- read_csv("/home/rafael/Documentos/dados daa cyclistic/dados/202011-divvy-tripdata.csv")
cyclistic_202012 <- read_csv("/home/rafael/Documentos/dados daa cyclistic/dados/202012-divvy-tripdata.csv")
cyclistic_202101 <- read_csv("/home/rafael/Documentos/dados daa cyclistic/dados/202101-divvy-tripdata.csv")
cyclistic_202102 <- read_csv("/home/rafael/Documentos/dados daa cyclistic/dados/202102-divvy-tripdata.csv")
cyclistic_202103 <- read_csv("/home/rafael/Documentos/dados daa cyclistic/dados/202103-divvy-tripdata.csv")
cyclistic_202104 <- read_csv("/home/rafael/Documentos/dados daa cyclistic/dados/202104-divvy-tripdata.csv")

#Analisando os tipos de dados
#Usando a função str() porque ela nos fornece informações de alto nível, como os nomes das colunas e o tipo de dados contidos nessas colunas.
str(cyclistic_202004)
str(cyclistic_202005)
str(cyclistic_202006)
str(cyclistic_202007)
str(cyclistic_202008)
str(cyclistic_202009)
str(cyclistic_202010)
str(cyclistic_202011)
str(cyclistic_202012)
str(cyclistic_202101)
str(cyclistic_202102)
str(cyclistic_202103)
str(cyclistic_202104)

#Existem duas grandes formas de junção de dados: UNIÃO e CRUZAMENTO
#Para que uma união seja possível, os dois ou mais conjuntos de dados precisam ter os mesmos campos. 
#Para que um cruzamento seja possível, os dois ou mais conjuntos de dados precisam ter pelo menos um campo em comum.
#Nesse caso, os campos estão em comum e por isso vou unir os dados

# rbind() Esta função é usada para combinar data fraames ou matrizes por linhas

#Unindo os dados

cyclistic_april_to_april <- data.frame(rbind(cyclistic_202004, cyclistic_202005, cyclistic_202006, cyclistic_202007,
                                             cyclistic_202008, cyclistic_202009, cyclistic_202010, cyclistic_202011, 
                                             cyclistic_202012, cyclistic_202101, cyclistic_202102, cyclistic_202103,
                                             cyclistic_202104))

#Limpeza e Tratamento dos Dados para analise

#Visualizando as 6 primeiras linhas do conjunto de dados
head(cyclistic_april_to_april)

#Visualizando as últimas linhas do conjunto de dados
tail(cyclistic_april_to_april)

#Mostra a estrutura do conjunto de dados
str(cyclistic_april_to_april)

#Fornece um resumo estatístico dos dados
summary(cyclistic_april_to_april)

#Abre uma visualização interativa dos dados em uma janela separada
View(cyclistic_april_to_april)

# Identificando os nomes das colunas e o número de linhas antes da limpeza e tratamento:
colnames(cyclistic_april_to_april)

numero_de_linhas1 <- nrow(cyclistic_april_to_april)
print(numero_de_linhas1) #3826978

#Classificar e filtrar
#Primeiro: Apagando linhas e colunas com valor null

#Verificando quais linhas tem valor null. Vai retornar os indices das linhas com valor null
linhas_nulas <- which(rowSums(is.na(cyclistic_april_to_april))> 0)
print(linhas_nulas)

cyclistic_april_to_april_no_null <- na.omit(cyclistic_april_to_april)
linhas_nulas_v2 <- which(rowSums(is.na(cyclistic_april_to_april_no_null))>0)
print(linhas_nulas_v2) #0

numero_de_linhas2 <- nrow(cyclistic_april_to_april_no_null)
print(numero_de_linhas2) #3592898

#verificando se ainda tem linhas na
cyclistic_april_to_april_no_null %>% 
  select(ride_id, rideable_type, started_at, ended_at, start_station_name, 
         start_station_id, end_station_name, end_station_id, start_lat, start_lng, member_casual) %>% 
  filter(!complete.cases(.))

#Tornando a visualização mais fácil 
as_tibble(cyclistic_april_to_april_no_null)

#head(cyclistic_april_to_april_no_null$data)

#Criando a coluna comeco_passeio
cyclistic_april_to_april_no_null <- cyclistic_april_to_april_no_null %>% 
  mutate(comeco_passeio = paste(hour(started_at), minute(started_at), second(started_at), sep = ":")
         )

#Criando a coluna fim_passeio
cyclistic_april_to_april_no_null <- cyclistic_april_to_april_no_null %>% 
  mutate(fim_passeio = paste(hour(ended_at), minute(ended_at), second(ended_at), sep = ":")
  )

as_tibble(cyclistic_april_to_april_no_null$comeco_passeio) #O tipo de value é chr
as_tibble(cyclistic_april_to_april_no_null$fim_passeio) #O tipo de value é chr

#Preciso converter para data/hora e fazer a diferença para achar a duração do passeio
#Utiliza o as.POSIXct para converter objetos para o tipo de data/hora e usa-los com difftime

#Esse é um jeito de fazer, porém eu preferir usar o difftime porque eu sei que vai me dar o resultado em sec
cyclistic_april_to_april_no_null <- cyclistic_april_to_april_no_null %>% 
  mutate(duracao_passeio = as.character(as.POSIXct(fim_passeio, format="%H:%M:%S") - as.POSIXct(comeco_passeio, format="%H:%M:%S")))
#Criando a coluna duracao_passeio
cyclistic_april_to_april_no_null <- cyclistic_april_to_april_no_null %>% 
  mutate(duracao_passeio = difftime(as.POSIXct(fim_passeio, format="%H:%M:%S"), 
                                    as.POSIXct(comeco_passeio, format="%H:%M:%S"), 
                                    units = "sec"))

duracao_passeio_v2 <- difftime(as.POSIXct(cyclistic_april_to_april_no_null$fim_passeio, format="%H:%M:%S"), 
                                    as.POSIXct(cyclistic_april_to_april_no_null$comeco_passeio, format="%H:%M:%S"), 
                                    units = "secs")

#Retirando os valores negativos de duracao_passeio
cyclistic_april_to_april_no_null <- subset(cyclistic_april_to_april_no_null, as.numeric(duracao_passeio) > 0)

#Linhas da cyclistic_april_to_april_no_null
nrow(cyclistic_april_to_april_no_null) #3553836

#Retirando os valores negativos
duracao_passeio_v2 <- subset(as.numeric(duracao_passeio_v2), duracao_passeio_v2 > 0)

#Formatando para HH:MM:SS
#Vou utilizar uma função propria
formatar_segundo <- function(segundos){
  horas <- floor(segundos / 3600)
  minutos <- floor((segundos %% 3600)/60)
  segundos_restantes <- floor(segundos %% 60)
  
  #Criando a string formatada
  resultado <- gsub("\\s+", "", as.character(paste(horas,":",minutos,":",segundos_restantes)))
  
  return(resultado)
  
}
#Formatando a coluana duracao_passeio
cyclistic_april_to_april_no_null$duracao_passeio <- formatar_segundo(duracao_passeio_v2)


# Criando a coluna "data" a partir da coluna "started_at"
cyclistic_april_to_april_no_null <- cyclistic_april_to_april_no_null %>% mutate(data = as.Date(started_at))


#Dia da semana. Criando a coluna dia_semana
cyclistic_april_to_april_no_null <- cyclistic_april_to_april_no_null %>% 
  mutate(dia_semana = weekdays(ymd(data)))

#transformando member_casual em fator

cyclistic_april_to_april_no_null$member_casual <- as.factor(cyclistic_april_to_april_no_null$member_casual)

View(cyclistic_april_to_april_no_null)

levels(cyclistic_april_to_april_no_null$member_casual)

#Estatísticas resumidas dos dados
skim(cyclistic_april_to_april_no_null$duracao_passeio)

#Criando a coluna km_percorridos usando as colunas start_lng, start_lat, end_lng e end_lat
#Vou utilizar a fórmula de Vincenty porque é mais precisa, para calcular a distância
cyclistic_april_to_april_no_null$km_percorridos <- distVincentySphere(
  cyclistic_april_to_april_no_null[, c("start_lng", "start_lat")],
  cyclistic_april_to_april_no_null[, c("end_lng", "end_lat")]
) / 1000 
#Essa formula me retorna a distancia em metros, daí eu dividir por 1000 para transformar em km

#média, mediana, máximo e minimo de duração de passeio dos ciclistas membros. Usando aggregate

aggregate(duracao_passeio_v2 ~ cyclistic_april_to_april_no_null$member_casual, FUN = mean)

mean(as.numeric(cyclistic_april_to_april_no_null$duracao_passeio))

#Obs.: Mudar o duracao_passeio para numeric
