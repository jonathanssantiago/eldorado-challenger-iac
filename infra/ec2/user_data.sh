#!/bin/bash
# Script simplificado para configurar Docker e executar aplicação Eldorado Challenge API
set -e

# Função para log
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a /var/log/user-data.log
}

log "Iniciando script de configuração..."

# Atualiza o sistema
log "Atualizando o sistema..."
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# Instala ferramentas essenciais
log "Instalando ferramentas essenciais..."
apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

# Instala o Docker
log "Instalando o Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y
apt-get install -y docker.io

# Inicia e habilita o serviço do Docker
log "Configurando o Docker..."
systemctl start docker
systemctl enable docker

# Adiciona o usuário ubuntu ao grupo docker
usermod -aG docker ubuntu

# Verifica se o Docker está funcionando
if ! systemctl is-active --quiet docker; then
  log "ERRO: O Docker não está em execução!"
  exit 1
fi

log "Docker instalado e funcionando corretamente."

# Baixa a imagem Docker
log "Baixando a imagem Docker..."
docker pull jonathanssantiagodev/eldorado-challenge-api:latest

# Inicia o contêiner diretamente na porta 80
log "Iniciando o contêiner Docker..."
docker run -d \
  --name eldorado-api \
  --restart always \
  -p 80:3000 \
  jonathanssantiagodev/eldorado-challenge-api:latest

# Verifica se o contêiner está rodando
if ! docker ps | grep -q eldorado-api; then
  log "ERRO: O contêiner não está em execução!"
  docker logs eldorado-api
  exit 1
fi

log "Contêiner iniciado com sucesso."

# Teste de conectividade local
log "Testando conectividade local..."
for i in {1..5}; do
  if curl -s localhost:80 >/dev/null; then
    log "Teste de conectividade local bem-sucedido!"
    break
  else
    log "Aguardando a aplicação iniciar... (tentativa $i)"
    sleep 5
  fi
done

log "Configuração concluída com sucesso!"

# Criar arquivo de conclusão
echo "$(date): Inicialização concluída com sucesso!" > /var/log/user-data-complete.log