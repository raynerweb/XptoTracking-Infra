# XptoTracking

## Postman Collection
A postman collection, pode ser importada e visualizada no diretorio postman.

## Portas
É necessário ter as seguintes portas livres no sistema operacional
> **5672** RabbitMQ

> **5431** PostgreSQL

> **8081** Telemetry API

> **8082** People API

> **8083** Vehicle API

> **8084** Tracking (Data) API

## Desenho da solução
### Fluxo Principal
A **VIATURA** sempre está enviando seus dados para monitoramento.
Neste caso é chamado a API de tracking. 
O recebimento e processamento é assincrono, para evitar gargalos, foi utilizado o rabbitmq para liberar a requisição o quanto antes.

A Api de tracking verifica se há viaturas e ou sensores registrados e o fluxo de registro da telemetria é armazenado.

Para caso de erro de negócio os logs deverão ser consultados.

O **Tracking Manager** poderá cadastrar novas viaturas, novos perfis de telemetria e novos motoristas bem como novas empresas.


![Tracking Solution](/assets/tracking_solution.jpg)


## Gerando as imagens docker

### Usando Linux

Caso esteja rodando linux, basta clonar esse projeto e garantir que tenha instalado:
- docker
- wget
- unzip

É necessario rodar apenas dois comandos.
```bash
bash prepare.sh
docker compose up -d    
```

### Usando Windows
Para instalar a solução de tracking é preciso baixar todos os projetos na branch master e descompactar todos os projetos

> wget -c https://github.com/raynerweb/telemetry/archive/refs/heads/master.zip

> wget -c https://github.com/raynerweb/tracking/archive/refs/heads/master.zip

> wget -c https://github.com/raynerweb/vehicle-python/archive/refs/heads/master.zip

> wget -c https://github.com/raynerweb/people/archive/refs/heads/master.zip

#### JAVA
Para os projetos Java (telemetry e tracking) é necessario o maven
Para compilar execute em cada um deles:

```bash
mvn -Pdev clean install
```

Apois compilar execute o docker build com as tags **tracking** e **telemetry**
```bash
docker build -t tracking
docker build -t telemetry
```


#### Python
Para os projetos Python é necessario apenas rodar o docker build com as tags **people** e **vehicle**
```bash
docker build -t people
docker build -t vehicle
```

Após esse gerar as imagens, rode o docker compose
```bash
docker compose up -d    
```