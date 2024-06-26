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

# rbind() Esta função é usada para combinar data frames ou matrizes por linhas

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
which(rowSums(is.na(cyclistic_april_to_april))> 0)


cyclistic_april_to_april_no_null <- na.omit(cyclistic_april_to_april)
which(rowSums(is.na(cyclistic_april_to_april_no_null))>0)
#0

nrow(cyclistic_april_to_april_no_null)
#3592898

#verificando se ainda tem linhas na
cyclistic_april_to_april_no_null %>% 
  select(ride_id, rideable_type, started_at, ended_at, start_station_name, 
         start_station_id, end_station_name, end_station_id, start_lat, start_lng, member_casual) %>% 
  filter(!complete.cases(.))

#Tornando a visualização mais fácil. Vai converter os diferentes tipos de objetos em tibbles. 
#Vai imprimir apenas as 10 primeiras linhas.
as_tibble(cyclistic_april_to_april_no_null)

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
                                    units = "sec")/60)

duracao_passeio_v2 <- difftime(as.POSIXct(cyclistic_april_to_april_no_null$fim_passeio, format="%H:%M:%S"), 
                                    as.POSIXct(cyclistic_april_to_april_no_null$comeco_passeio, format="%H:%M:%S"), 
                                    units = "secs")

#Criando hora a partir do comeco_passeio
cyclistic_april_to_april_no_null$hora <- as.numeric(gsub(":", "", substr(cyclistic_april_to_april_no_null$comeco_passeio, 1, 2)))

#Converter para numeric
#Retirando os valores negativos de duracao_passeio
#Posso usar o subset ou manipular um vetor dentro do data frame 
#cyclistic_april_to_april_no_null <- as.numeric(subset(cyclistic_april_to_april_no_null, as.numeric(duracao_passeio) > 0))
cyclistic_april_to_april_no_null <- cyclistic_april_to_april_no_null[as.numeric(cyclistic_april_to_april_no_null$duracao_passeio) > 0, ]
cyclistic_april_to_april_no_null$duracao_passeio <- as.numeric(cyclistic_april_to_april_no_null$duracao_passeio)
str(cyclistic_april_to_april_no_null$duracao_passeio)

#Linhas da cyclistic_april_to_april_no_null
nrow(cyclistic_april_to_april_no_null) #3553836

#Retirando os valores negativos
duracao_passeio_v2 <- subset(as.numeric(duracao_passeio_v2), duracao_passeio_v2 > 0)


# Criando a coluna "data" a partir da coluna "started_at"
cyclistic_april_to_april_no_null <- cyclistic_april_to_april_no_null %>% mutate(data = as.Date(started_at))
head(cyclistic_april_to_april_no_null$data)
str(cyclistic_april_to_april_no_null$data) #Date

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

#média, mediana, máximo e minimo de duração de passeio. Usando o aggregate que me retorna o  resultado dos ciclistas casual e member
aggregate(as.numeric(cyclistic_april_to_april_no_null$duracao_passeio) ~ cyclistic_april_to_april_no_null$member_casual, FUN = mean)
aggregate(as.numeric(cyclistic_april_to_april_no_null$duracao_passeio) ~ cyclistic_april_to_april_no_null$member_casual, FUN = median)
aggregate(as.numeric(cyclistic_april_to_april_no_null$duracao_passeio) ~ cyclistic_april_to_april_no_null$member_casual, FUN = max)
aggregate(as.numeric(cyclistic_april_to_april_no_null$duracao_passeio) ~ cyclistic_april_to_april_no_null$member_casual, FUN = min)

#Outro jeito de fazer
mean(cyclistic_april_to_april_no_null$duracao_passeio[cyclistic_april_to_april_no_null$member_casual == "casual"]) #media para os ciclistas casual
mean(cyclistic_april_to_april_no_null$duracao_passeio[cyclistic_april_to_april_no_null$member_casual == "member"])  #media para os ciclistas membe

#média, mediana, máximo e minimo de de km percorridos, independete do tipo de usuario
aggregate(as.numeric(cyclistic_april_to_april_no_null$km_percorridos) ~ cyclistic_april_to_april_no_null$member_casual, FUN = mean)
aggregate(as.numeric(cyclistic_april_to_april_no_null$km_percorridos) ~ cyclistic_april_to_april_no_null$member_casual, FUN = median)
aggregate(as.numeric(cyclistic_april_to_april_no_null$km_percorridos) ~ cyclistic_april_to_april_no_null$member_casual, FUN = max)
aggregate(as.numeric(cyclistic_april_to_april_no_null$km_percorridos) ~ cyclistic_april_to_april_no_null$member_casual, FUN = min)

#moda da semana, independente do tipo dos membros(casual ou membro)
#Numero de viagens para usuario por dia da semana
tabela_freq_member <- table(cyclistic_april_to_april_no_null$dia_semana[cyclistic_april_to_april_no_null$member_casual == "member"])
tabela_freq_casual <- table(cyclistic_april_to_april_no_null$dia_semana[cyclistic_april_to_april_no_null$member_casual == "casual"])
#calculando a moda 
moda_v1 <- names((tabela_freq_member)[which.max(tabela_freq_member)])
moda_v2 <- names((tabela_freq_casual)[which.max(tabela_freq_casual)])
print(moda_v1) #sábado
print(tabela_freq_member)
#domingo  quarta  quinta  sábado segunda   sexta   terça 
#272539  310414  307698  327013  276227  319257  296321 

print(tabela_freq_casual)
#domingo  quarta  quinta  sábado segunda   sexta   terça 
#269357  156487  163943  338144  153732  210811  151893

print(moda_v2) #sábado


#gráfico de frequência dos usuários casuais
tabela_freq_casual <- data.frame(tabela_freq_casual)
View(tabela_freq_casual)
class(tabela_freq_casual)
colnames(tabela_freq_casual) <- c("weekdays", "frequencia")

ggplot(data = tabela_freq_casual, aes(x = weekdays, y = frequencia, fill = frequencia))+
  geom_bar(stat = "identity",  position = "dodge") +
  #ggtitle("Frequência de viagens para usuários casuais")
  labs(title="Frequência de viagens para usuários casuais de 04/2020 - 04/2021",
     caption="Dados coletados por Rafael Brendo")+
  ylab("Frequência de Uso")+
  xlab("Dias da semana")+
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())

#gráfico de frequência dos usuários membros
tabela_freq_member <- data.frame(tabela_freq_member)
class(tabela_freq_member)
View(tabela_freq_member)
colnames(tabela_freq_member) <- c("weekdays", "frequencia")

#Gráfico que mede a frequencia x dia da semana, para usuários membros 
ggplot(data = tabela_freq_member, aes(x= weekdays, y= frequencia, fill=frequencia))+
  geom_bar(stat = "identity", position = "dodge")+
  #ggtitle("Frequência de viagens para usuários membros")+
  labs(title="Frequência de viagens para usuários membros de 04/2020 - 04/2021",
       caption="Dados coletados por Rafael Brendo")+
  ylab("Frequência de Uso")+
  xlab("Dias da semana")+
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())

#Demanda do de cada usuario por dia da semana 
ggplot(data = cyclistic_april_to_april_no_null, aes(x = dia_semana, fill = member_casual))+
  geom_bar(position = "dodge")+
  scale_y_continuous(labels = scales::comma)+
  labs(title = "Demanda de cada usuário por dia da semana", x = "Dia da semana", y = "Numero de Passeios", fill = "Tipo de Ciclista", caption="Dados coletados por Rafael Brendo")+
  theme_minimal()

#Horario de cada passeio por usuário
ggplot(data = cyclistic_april_to_april_no_null, aes(x = hora, fill = member_casual))+
  geom_bar(position = "dodge")+
  scale_y_continuous(labels = scales::comma)+# Usando scales::comma para formatar os rótulos dos valores
  labs(x = "Hora", y = "Contagem")+
  theme_minimal()

media_membro_dia_da_semana_km__percorrido <- aggregate(km_percorridos ~ member_casual, data = cyclistic_april_to_april_no_null, FUN = mean)  
print(media_membro_dia_da_semana_km__percorrido)
#aggregate(km_percorridos ~ dia_semana + member_casual, data = cyclistic_april_to_april_no_null, FUN = mean)  
#Media de Km percorridos por tipo de usuário
ggplot(data = media_membro_dia_da_semana_km__percorrido, aes(x = member_casual, y = km_percorridos, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_y_continuous(labels = scales::comma) +
  labs(y = "Média de Km percorridos", x = "Tipo de Ciclista", title = "Média de km percorridos por tipo de usuário") +
  theme_minimal() +
  theme(legend.position = "none") +  # Remover a legenda porque as cores são autoexplicativas
  scale_fill_manual(values = c("#66c2a5", "#fc8d62"))  # Escolha de cores mais distintas


#Km percorridos por tipo de usuário
ggplot(data = cyclistic_april_to_april_no_null, aes(x = dia_semana, y = km_percorridos, fill = member_casual))+
  geom_bar(stat = "identity", position = "dodge")+
  scale_y_continuous(labels = scales::comma)+
  labs(x = "Dia da semana", y = "Km percorridos", title = "Km percorridos por dia da semana", fill= "Tipo de Ciclista")+
  theme_minimal()
   

#Frequencia de casual e member
frequencia <- table(member_casual = cyclistic_april_to_april_no_null$member_casual)
view(frequencia)
print(frequencia)

#Vai me retornar a proporção de usuarios membros e usuarios casuais
porcentagem <- round(prop.table(frequencia) * 100, 2)
print(str(porcentagem))

#transformando em data frame com os percentuais
percentuais_grafico <- data.frame(percentual = porcentagem)
colnames(percentuais_grafico) <- c("member_casual", "frequencia")
print(str(percentuais_grafico))
View(percentuais_grafico)

ggplot(percentuais_grafico, aes(x = member_casual, y = frequencia, fill=member_casual))+
  geom_bar(stat = "identity", position = "dodge")+
  labs(x = "Tipo de Ciclista", y = "Percentual (%)")+
  theme_minimal() +
  guides(fill = guide_legend(title = "Tipo de Ciclista"))

#duracao_passeio_v2 <- round(duracao_passeio_v2)
View(duracao_passeio_v2)
media_membro_dia_da_semana <- aggregate(duracao_passeio ~ dia_semana + member_casual, data = cyclistic_april_to_april_no_null, FUN = mean)
View(media_membro_dia_da_semana)


# Gráfico de barras com a Média de duração do Passeio x Dia da Semana, relacionado ao Tipo de Usuário
ggplot(media_membro_dia_da_semana, aes(x = dia_semana, y = duracao_passeio, fill= member_casual))+
  geom_bar(stat = "identity", position = "dodge")+
  labs(x = "Dia da Semana", y = "Tempo médio (minutos)", title ="Media de duração do passeio ", fill = "Tipo de Ciclista", 
        caption="Dados coletados por Rafael Brendo")+
        theme(plot.title = element_text(hjust = 0.5))
 
media_tempo_por_usuario <- aggregate(duracao_passeio ~ member_casual, data = cyclistic_april_to_april_no_null, FUN = mean)

ggplot(data = media_tempo_por_usuario, aes(x = member_casual, y = duracao_passeio, fill = member_casual))+
  geom_bar(stat = "identity", position = "dodge")+
  labs(title = "Media de duração do passeio por tipo de ciclista", y = "Tempo Medio(minutos)", caption="Dados coletados por Rafael Brendo")+
  guides(fill = guide_legend(title = "Tipo de Ciclista"))+
  theme(axis.title.x = element_blank(), plot.title = element_text(hjust = 0.5))
  



#Formatando para HH:MM:SS
#Vou utilizar uma função propria
formatar_segundo <- function(segundos){
  horas <- floor(segundos / 3600)
  minutos <- floor((segundos %% 3600)/60)
  segundos_restantes <- floor(segundos %% 60)
  
  #Criando a string formatada
  resultado <- as.numeric(format(as.POSIXct(gsub("\\s+", "", as.character(paste(horas,":",minutos,":",segundos_restantes))), format="%H:%M:%S"), "%H:%M:%S"))
  
  return(resultado)
  
}
#Formatando a coluana duracao_passeio
cyclistic_april_to_april_no_null$duracao_passeio <- formatar_segundo(duracao_passeio_v2)
