import xmltodict
import json, ast
import collections

# Function converts the elements of a unicode dictionary into a regular string 
def convert(data):
    if isinstance(data, basestring):
        return str(data)
    elif isinstance(data, collections.Mapping):
        return dict(map(convert, data.iteritems()))
    elif isinstance(data, collections.Iterable):
        return type(data)(map(convert, data))
    else:
        return data

# MAIN func, read XML and spit out the CSV formatted 
#******** NAME OF XML FILE YOU OPEN ********
xmlFile = 'data'
with open ("%s.xml" % xmlFile, "r") as myfile:
    data = myfile.read()
ast.literal_eval(json.dumps(data))
xmlDict = xmltodict.parse(str(data))

converted = convert(xmlDict)
trials = len(converted['User']['Direction'])
name = str(converted['User']['@Name'])
difficulty = str(converted['User']['@Difficulty'])
subID = str(converted['User']['@ID'])
csvFile = open("%s_%s_%s.csv" % (name, subID, difficulty), "w")

print convert(xmlDict)
print ('# of trials,'), trials
time = str(converted['User']['Time'])
csvFile.write('Correct Answer,Subject Answer,'+ time + '\n')

#Loop through all trials
for i in range (0,trials):
	convertThis = convert(xmlDict['User']['Direction'][i])
	commaValues = convertThis.replace(" ",",")
	print (commaValues + '\n')
	csvFile.write(commaValues + '\n')
