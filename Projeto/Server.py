import socket
from Get_data import pegar_desenho
PORT = 8080
HOST = '127.0.0.1'
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server:
	server.bind((HOST,PORT))
	server.listen()
	client, addr = server.accept()
	with client:
		print("Conectado a ", addr)
		while client:
			escolha = client.recv(1024)
			if not escolha:
				break
			client.sendall(pegar_desenho(escolha.decode()).encode('utf8'))
