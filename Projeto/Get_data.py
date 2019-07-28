from quickdraw import QuickDrawData
#Escolha_do_usuario = input("O gostaria de desenhar? ")
def pegar_desenho(Escolha = "Flower"):
	qd = QuickDrawData()
	#arquivo = open("data.doc","w")
	arquivo_str =''
	desenho = qd.get_drawing(Escolha)
	desenho.image.save("Desenho.png")
	data_array = desenho.image_data
	print (data_array)
	print(len(data_array))
	#arquivo.write("{} ".format(len(data_array))) #number of strokes
	arquivo_str += "{} ".format(len(data_array))
	for stroke in desenho.strokes:
		#arquivo.write("{} ".format(len(stroke)))
		arquivo_str += "{} ".format(len(stroke))
		print(len(stroke))
		for x,y in stroke:
			#arquivo.write("{} {} ".format(x, y))
			arquivo_str += "{} {} ".format(x, y)

		#print(len(stroke))
	#arquivo.close()
	return arquivo_str