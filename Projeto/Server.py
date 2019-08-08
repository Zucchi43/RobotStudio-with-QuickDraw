#!/usr/bin/env python3
import socket
from Get_data import pegar_desenho #função handler para buscar data na internet

PORT = 8080
HOST = ''#O host é qualquer IPV4 disponivél no computador
#Cria o socket e anexa o endereço e a porta definidos a ele
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server:
	server.bind((HOST,PORT))
	print ("Começando server em ",HOST)

	while True:
		server.listen()#Aguarda algum cliente querer se conectar
		client, addr = server.accept() #aceita a conexão e o descreve como client
		with client:
			print("Conectado a ", addr)
			open("data.doc", "w").close()#Limpa o arquivo de texto para futuramente o robo escrever a data nele

			while client:
				escolhab = client.recv(4096) #recebe a string de escolha do cliente em bytes
				escolha = escolhab.decode() #transforma os bytes em uma string

				if escolha:
					print ("O cliente mandou:",escolha)
				if escolha == 'desligar_server' :
					exit() #caso o cliente (robo) enccerre sua rotina o server tambem encerra sua atividade
				if not escolha:
					print("Awaiting for client's request")# aguarda o cliente mandar a proxima escolha
					break

				client.sendall(pegar_desenho(escolha).encode('utf8')) #devolve para o client as informações sobre o desenho que o cliente selecionou
