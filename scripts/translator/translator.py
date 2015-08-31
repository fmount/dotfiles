#!/bin/python

#Link Reference: http://api.wordreference.com/c4de4/json/enit/worked
import requests,json
import pdb

__author__="_aayek"

_API_KEY='c4de4' #encode in base64 after finish the script..
_ENDPOINT='http://api.wordreference.com'

_AVAILABLE_DICTS=('enit','iten')
_MODE='json'
_MAIN_DATA=('PrincipalTranslations','AdditionalTranslations','Entries',('original','Compounds'))

def represent(origin_term,json_data,depth):
		for item in range(0,depth):
			try:
				sense = json_data[str(item)]['OriginalTerm']['sense']
				#pdb.set_trace()
				translation = json_data[str(item)]['FirstTranslation']['term']
				print "Original Term: "+origin_term+" with sense: "+sense
				print "Translation: "+translation
			except:
				#print "[!Info] There aren't others main translations available for this word!"
				pass

def build_request(req_base,main):
	dp = 0
	while dp!=len(main):
		req_base = req_base[main[dp]]
		dp +=1
	return req_base

def translate(q,depth):
	r = requests.get(_ENDPOINT+"/"+_API_KEY+"/"+_MODE+"/"+_AVAILABLE_DICTS[0]+"/"+q)
	if(r.status_code != 200):
		return "[!] W_Reference Request Error!"
	index=0
	for i in _MAIN_DATA:
		try:
			if isinstance(_MAIN_DATA[index],tuple):
				print "------------------"
				print "ORIGINAL COMPOUNDS"
				print "------------------"
				req = build_request(r.json(),_MAIN_DATA[index])
				represent(q,req,depth)
			else:
				print i.upper()
				print "---------"
				represent(q,r.json()['term0'][i],depth)
				print "---------"
		except:
			pass
		index+=1


def main():
	try:
		while(True):
			inn = raw_input("What? ")
			translate(inn,5)
	except(KeyboardInterrupt, SystemExit):
		print("\n")
		exit(0)




if __name__ == '__main__':
		main()
