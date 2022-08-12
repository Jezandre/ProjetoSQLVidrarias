## Projeto Banco de dados de vidrarias

<hr size="100"> <!-- LINHA HORIZONTAL -->

## OBJETIVO

Em um laboratório de controle de qualidade que utiliza metodologia de análises químicas é necessário que seus instrumentos de trabalho estejam com os controles
de calibração e verificação em dia. O intuito deste projeto é criar e simular um sistema de banco de dados em SQLserver utilizando a linguagem SQL para armazenar
informações relevantes de uma vidraria. Este projeto permitirá visualisar os seguintes aspectos:

- Criação de formulários automáticos de forma que o operador responsável por analisar não utilize equipamentos com datas de validade de calibração e verificação vencidas;
- Facilitar o trabalho da equipe de qualidade mantendo os registros sempre atualizados evitando assim não conformidades;
- Facilitar na apresentação de documentação para auditorias;
- Evitar erros que poderiam ser causados por preenchimentos manual;
- Possibilitar a conexão deste banco de dados com o programa de cálculo forncendo assim as informações corretas para os cálculos de incerteza;

Além disso outro aspecto pessoal seria a possibilidade de manusear, treinar e criar soluções em SQL partindo de um problema que já tenho uma base de conhecimento prático.

<hr size="100"> <!-- LINHA HORIZONTAL -->

## INTRODUÇÃO

Ensaio químico são ensaios realizados dentro de um laboratório afim de se avaliar a qualidade ou quantidade de determinado componente em um produto. Esses ensaios passam
por rigorosos testes de validação, que se baseiam na obtenção e tratamento estatístico dos dados obtidos durante os testes com objetivo de avaliar se o método realmente
atende ao que ele propõe. Por exemplo eu preciso saber quanto de açúcar tem uma bolacha (no caso seria zero porque bolacha é um soco na cara rsrs, brincadeira) ou biscoito
para as pessoas que entendem do assunto. Primeiramente se avalia padrões semelhantes, em seguida se aplica diretamente no biscoito o método e por meio de estatísca se compara
se esse método é realemente aplicável para este fim que é analisar quantidade de açúcar no biscoito.
Para se garantir a qualidade de um ensaio químico diversos fatores contibuem para se obter resultados mais precisos, como por exemplo temperatura, umidade, pureza de reagente,
calibração das vidraria entre outros aspectos. 
A calibração nada mais é que aferir a capacidade real de um equipamento utilizando padrões conhecidos em ambientes com fatores super-controlados. Por isso utilizar-se de
equipamentos calibrados são de suma importância para garantir a qualidade do ensaio. E garantir que esses equipamentos se encontrem em condições ideais contibuirá diretamente
na qualidade e eficiencia de um método analítico.
Com isso o propósito deste projeto é desenvolver um banco de dados que armazene as informações relevantes para a construção destes controles. Então bora colocar mão na massa.

<hr size="100"> <!-- LINHA HORIZONTAL -->

## ANÁLISE DE REQUISITOS

O primeiro passo a ser tomado é definir quais parametros precisam ser armazenados e como eles serão armazenados. O sistema de banco de dados utilizados será o SQLserver
da Microsoft e serão utilizadas estruturas relacionais para armazenar as verificações e calibrações. E a lógica é a seguinte, todas as vidrarias armazenadas no banco terão
de ser calibradadas podem ter um ou mais datas de calibração, e todas as vidrarias calibradas podem ter uma ou mais verificações.
O ambiente OLTP será definido da seguinte maneira:

Serão criadas três tabelas com as seguintes colunas:

**Vidraria:**
- Tipo de vidraria
- Marca
- Identificação da Vidraria
- Volume Nominal
- Volume real

**Calibração:**
- Responsável pela calibração
- Data de Calibração
- Prazo para próxima calibração
- Número de certificado
- Empresa ou responsável pela calibração

**Verificação:**
- Responsável pela calibração
- Data de verificação
- Prazo de verificação
- Tipo de verificação

<hr size="100"> <!-- LINHA HORIZONTAL -->

## MODELO CONCEITUAL

O modelo coneceitual é o diagrama onde é possível observar as relações entre as tabelas. Os pontos em roxo são as chaves á esquerda são as chaves primarias e os pontos 
roxo á direita são as chaves estrangeiras.
A premissa é a seguinte todas as vidrarias a serem armazenadas no banco de dados devem ser calibradas porém, a verificação não é um ítem obrigratório.

Em um modelo conceitual de banco de dados, utiliza-se o termo de cardinalidade, que nada mais é que os números entre parênteses ao lado de cada extremidade da relação. Elas podem ser:

(0,n)
(0,1)
(1,1)
(1,n)

O número no lado esquerdo representa a obrigatoriedade, enquanto que o número do lado direito representa a quantidade de possibilidades.

Número lado esquerdo:
0= Não Obrigatório
1= Obrigatório

Número lado direito:
1=Pode haver apenas uma relação
n=Pode ter mais de uma relação

Esses números devem ser sempre analisado de uma tabela em relação á outra exemplo:

Uma vidraria é obrigatório ter uma ou mais calibrações então a relação entre vidraria e calibração é (1,n). No entanto uma calibração só pode pertencer a uma vidraria (1,1).


<img src="https://github.com/Jezandre/ProjetoBIVidrarias/blob/main/Modelagem%20Conceitual-2.png">

<hr size="100"> <!-- LINHA HORIZONTAL -->

## CRIANDO O MODELO LÓGICO

No link abaixo mostra os códigos para a etapa de modelagem física bem como a adição de Constraints, ela determina a regra de como as informações devem ser alimentadas. 

https://github.com/Jezandre/ProjetoBIVidrarias/blob/main/02%20-%20Create%20Tables%20Vidrarias.sql

Constraints ou delimitadores é um comando utilizada para delimitar certo campo dentro de um banco de dados. 
Essa função é utilizada para delimitar os dados que entrarão como Foreign Key(FK). 
Como a FK é um valor que vem de uma primary Key (PK) de outra tabela, é preciso assegurar que este valor 
seja colocado na tabela relacionada de forma correta.

Depois de executado esse comando é possível visualizar o modelo lógico das tabelas relacionais no SQLserver.


<hr size="100"> <!-- LINHA HORIZONTAL -->

## MODELO LÓGICO

O modelo lógico é onde são definidos qual banco de dados será utilizado para armazenar as informações. Neste caso o banco escolhido foi o SQLserver da Micrsoft então a estrutura
fica desta forma:


<img src="https://github.com/Jezandre/ProjetoBIVidrarias/blob/main/Modelo%20l%C3%B3gico.jpg">

<hr size="100"> <!-- LINHA HORIZONTAL -->

## INSERINDO DADOS ALEATÓRIOS NA TABELA VIDRARIA

Continuando a elaboração do meu projeto, uma das grandes dificuldades de se estudar banco de dados para uma análise é como criar dados fictícios. 
Imagina o seguinte você quer criar uma tabela com pelo menos 1000 dados e ter que ficar digitando dado por dado, é extremamente difícil.

Uma das opções é utilizar sites que gerem esses tipos de dados, mas no meu caso eu queria explorar um pouco dos meus conhecimentos em SQL. 
Então abaixo segue o link do código com o procedimento que eu fiz para poder alimentar a primeira das minhas tabelas desse projeto.

https://github.com/Jezandre/ProjetoBIVidrarias/blob/main/03%20-%20Create%20dados%20alet%C3%B3rios.sql

Primeiramente criei uma tabela com 10 linhas com as informações que eu precisava, marca de vidraria, tipo de vidraria e volume.

Em seguida criei uma procedure utilizando a função "rand()" para criar um número aleatório e esse número se relacionar ao item que eu queria que fosse lançado em 
determinda coluna.

Utilizei a rand() também para multiplicar o valor do volume nominal e obter dados mais reais de uma vidraria como podem ver na coluna volume real. 
E assim consegui alimentar com mais de mil dados aleatórios a minha tabela de vidrarias.

Na imagem podemos visualizar os dados na Tabela vidraria

<img src="https://github.com/Jezandre/ProjetoBIVidrarias/blob/main/Tabela%20Vidraria.jpg">


<hr size="100"> <!-- LINHA HORIZONTAL -->

## INSERINDO DADOS ALEATÓRIOS NA TABELA CALIBRAÇÃO


Seguindo no meu projeto, um dos maiores desafios de se estudar sobre dados é obter estes dados de forma aleatória, geralmente é difícil encontrar e produzir dependendo
do tema que você precisa abordar.

Porém saber se virar nessas condições é talvez o melhor exercício.

O desafio de hoje era colocar nomes, números, e datas aleatórios. Bom, para os nomes utilizei um esquema de uma tabela auxiliar e a função rand() do post anterior, para
criar números aleatórios a função rand() (lembrando que nesse caso os números poderiam de repetir sem problemas).

Nas datas eu utilizei um código que aprendi em um dos cursos do Felipe Mafra . E fica uma dica sempre salvem os códigos que vocês aprendem nos cursos.

Abaixo o link dos códigos

https://github.com/Jezandre/ProjetoBIVidrarias/blob/main/04%20-%20Create%20dados%20alet%C3%B3rios%20Tabela%20Calibra%C3%A7%C3%A3o.sql

e assim ficou a tabela de registro de calibração

<img src="https://github.com/Jezandre/ProjetoBIVidrarias/blob/main/Tabela%20Calibra%C3%A7%C3%A3o.jpg">


<hr size="100"> <!-- LINHA HORIZONTAL -->

## CRIANDO VIEWS

Continuando meu projeto, desta vez realizei a criação de Views utilizando o SQL.

Para isso os desafios foram trazer o prazo que foi fornecido em anos somados com a data em que foi realizado a calibração e avaliar se o equipamento está com 
calibração vencida ou não.

É possível fazer isso utilizando as funções DATEADD para adicionar, DATEDIFF para subtrair, GETDATE() para data atual e CASE que é equivalente ás funções SE 
em outras linguagens de programação.

<img src="https://github.com/Jezandre/ProjetoBIVidrarias/blob/main/View%20Relat%C3%B3rio%20geral.jpg">

Além disso criei uma View para avaliar as quantidades de equipamentos dentro e fora da validade.

<img src="https://github.com/Jezandre/ProjetoBIVidrarias/blob/main/Relat%C3%B3rio%20de%20quantidades%20vencidas%20e%20v%C3%A1lidas.jpg">

Esse relatório pode ser muito útil para avaliar as condições operacionais de tais equipamentos, além de fornecer uma ideia de quantos equipamentos precisam ser 
reavaliados. Associando essas informações á outros processos automáticos, acredito que seja possível criar alertas para que sejam feitas as reavaliações.

Uma view também pode ser muito útil para levar os dados para uma ferramenta de ETL seja Pentaho, IntegrationServices, já que algumas Querys podem ser gigantescas. 
Porém fazer cálculos em um banco de dados pode interferir no desempenho do mesmo.

O código caso queiram adaptar encontra-se em 

https://github.com/Jezandre/ProjetoBIVidrarias/blob/main/05%20-%20Create%20View%20da%20Tabela%20Calibra%C3%A7%C3%A3o.sql


<hr size="100"> <!-- LINHA HORIZONTAL -->

## CRIANDO VALORES ALEATÓRIOS PARA TABELA VERIFICAÇÃO

Olá pessoal dando mais um passo no meu projeto de banco de dados de vidrarias, tive que quebrar um pouco a cabeça com o seguinte problema.

Partindo do pressuposto que o laboratório tem todas as suas verificação em dia, precisava alimentar a tabela de verificações com dados das datas. 
Porém essas datas precisam respeitar as seguintes regras:

- Toda vidraria calibrada precisa ter uma data de verificação.

- Mesmo as vidrarias com a data de validade da calibração vencidas, precisam do registro de verificação delas no banco durante o período em que ela estava calibrada. 
Por exemplo se uma vidraria foi calibrada em 2/2/2017 e venceu em 2/2/2019, o período entre esses espaço de calibração precisam das datas de verificações registradas 
conforme o prazo de cada uma.

- Se uma vidraria venceu sua validade de calibração ela não pode ser utilizada, portanto ela não pode ter verificações após a data de validade.

- As verificação só podem ser registradas se elas tiverem sido efetuadas. Então se uma vidraria ainda está dentro da validade não podem haver registros após a data de 
hoje.

No link abaixo você pode ver o código que utilizei para resolver esse problema

https://github.com/Jezandre/ProjetoSQLVidrarias/blob/main/06%20-%20Create%20dados%20alet%C3%B3rios%20Tabela%20Verificacao.sql

Fiz algumas alterações no processo colocando já a tabela de verificações. Coloquei de forma que o nome do Responsável variasse conforme a data de verificação fosse inserida pois em um laboratório qualquer pessoa que faz parte do escopa da qualidade pode inserir as novas verificações.

Na imagem abaixo é possível visualizar como ficaram os dados depois de inseridos.

<img src="https://github.com/Jezandre/ProjetoSQLVidrarias/blob/main/tABELAS%20ALIMENTADAS.png">

Na imagem abaixo uma sequencia de inner join de forma que fosse possível visualizar os dados das tabelas unidas.

<img src="https://github.com/Jezandre/ProjetoSQLVidrarias/blob/main/tABELAS%20VERIFICACAO.png">

E com isso praticamente finalizo a construção do banco de dados. O próximo passo agora é criar visualizações no #powerBI pra deixar dinâmico a visulização destes 
controles.


