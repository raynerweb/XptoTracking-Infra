# XptoTracking

## Gerando as imagens

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


####Python
Para os projetos Python é necessario apenas rodar o docker build com as tags **people** e **vehicle**
```bash
docker build -t people
docker build -t vehicle
```

Após esse gerar as imagens, rode o docker compose
```bash
docker compose up -d    
```