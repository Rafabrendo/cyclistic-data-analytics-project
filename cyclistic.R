library(tidyverse)
library(skimr)
library(janitor)

#2ª etapa: Identificando como os dados estão organizados

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