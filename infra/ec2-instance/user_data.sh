#!/bin/bash
sudo apt update -y
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu

docker run -p 80:3000 jonathanssantiagodev/eldorado-challenge-api:latest