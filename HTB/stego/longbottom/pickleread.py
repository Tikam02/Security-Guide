import pickle

f = open('/root/Hunt/HTB/stego/longbottom/_socute.jpg.extracted/donotshare')

o = pickle.load(f)

outstr = ''
for line in o:
	for char,n in line:
		outstr += char*n
	outstr += '\n'
print outstr
