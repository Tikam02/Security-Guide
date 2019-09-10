from itertools import product
import string
dictionnare={'2': 'A', '22':'B','222' : 'C',
'3': 'D', '33':'E','333' : 'F',
'4': 'G', '44':'H','444' : 'I',
'5': 'J', '55':'K','555' : 'L',
'6': 'M', '66':'N','666' : 'O',
'7': 'P', '77':'Q','777' : 'R','7777' : 'S',
'8': 'T', '88':'U','888' : 'V',
'9': 'W', '99':'X','999' : 'Y','9999' : 'Z',
}
cipher_text='''444333 99966688 277733 7773323444664 84433 22244474433777 99966688 277733 666552999 99966688777 777744277733 666333 84433 443344477778 4447777 44466 99966688777 4466688777733 84433 5533999 8666 84433 55566622255 4447777 22335556669 4666 8666 727774447777
				47777888 995559888 4555 47777888 44999988 666555997 8555444888477744488866888648833369'''
text='''IF YOU ARE READING THE CIPHER YOU ARE OKAY YOUR SHARE OF THE HEIST IS IN YOUR HOUSE THE KEY TO THE LOCK IS BELOW GO TO PARIS 
		GSV XLWV GL GSV HZU OLXP TLIVGRIVNVMGUFMW '''

cipher_text=cipher_text.split()
def get_word(number):
	word=number[0]
	plain=""
	for i in range(1,len(number)):
		if number[i]==number[i-1]:
			word+=number[i]
		else:
			plain+=dictionnare[word]
			word=number[i]
	plain+=dictionnare[word]
	return plain
plain_text=""
for ele in cipher_text:
	plain_text+=get_word(ele)
	plain_text+=' '
#print(plain_text)  #IF YOU ARE READING THE CIPHER YOU ARE OKAY YOUR SHARE OF THE HEIST IS IN YOUR HOUSE THE KEY TO THE LOCK IS BELOW GO TO PARIS
                   # GSV XLWV GL GSV HZU OLXP TLIVGRIVNVMGUFMW


lower=list(string.ascii_lowercase)
vocabulaire="GSV XLWV GL GSV HZU OLXP TLIVGRIVNVMGUFMW"
flag=vocabulaire.split()
FLAG=""
for ele in flag:
	for char in ele:
		number=25-lower.index(char.lower())
		FLAG+=lower[number].upper()
	FLAG+=" "
print(FLAG)   
