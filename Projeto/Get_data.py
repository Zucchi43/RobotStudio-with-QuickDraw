from quickdraw import QuickDrawData #API do quickdraw, necessita-se instalar atraves de "pip install quickdraw"
import random #biblioteca de aleatoriedade do python

#Função de pegar os dados na internet
def pegar_desenho(Escolha = "flower"):
	qd = QuickDrawData() #define todos o dataset disponivel
	arquivo_str ='' #começa uma string onde as informaçoes serão escritas

	if Escolha != "random":
		desenho = qd.get_drawing(Escolha) #desenho especifico
	else:
		desenho = qd.get_drawing(random.choice(qd.drawing_names)) #desenho aleatorio

	desenho.image.save("Desenho.png")
	data_array = desenho.image_data #data bruto

	print (data_array)
	print(len(data_array))

	#number of strokes
	arquivo_str += "{} ".format(len(data_array))

	for stroke in desenho.strokes:
		#tamanho do stroke
		arquivo_str += "{} ".format(len(stroke))
		print(len(stroke))

		for x,y in stroke:
			#stroke
			arquivo_str += "{} {} ".format(x, y)

	return arquivo_str #devolve a string construida