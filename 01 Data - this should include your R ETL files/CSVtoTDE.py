import dataextract as tde
import os
import datetime
import csv

#step 1: Create the Extract fiel and open the .csv
tdefile = tde.Extract('CarConsumpCSVExtract.tde')
csvReader = csv.reader(open('carconsump.reformatted.csv', 'rb'), delimiter = ',', quotechar = '"')

if tdefile.hasTable('Extract'):
	table = tdefile.openTable('Extract')
	tableDef = table.getTableDefinition()
else:
	# Step 2: Creat the tableDef
	tableDef = tde.TableDefinition()
	tableDef.addColumn('manufacturer', tde.Type.CHAR_STRING)#1
	tableDef.addColumn('year', tde.Type.DATE)#0
	tableDef.addColumn('model', tde.Type.CHAR_STRING)#2
	tableDef.addColumn('engine', tde.Type.CHAR_STRING)#3
	tableDef.addColumn('euro_standard', tde.Type.INTEGER)#4
	tableDef.addColumn('transmission', tde.Type.CHAR_STRING)#5
	tableDef.addColumn('transmission_type', tde.Type.CHAR_STRING)#6
	tableDef.addColumn('engine_capacity', tde.Type.INTEGER)#7
	tableDef.addColumn('fuel_type', tde.Type.CHAR_STRING)#8
	tableDef.addColumn('urban_metric', tde.Type.DOUBLE)#9
	tableDef.addColumn('extra_urban_metric', tde.Type.DOUBLE)#10
	tableDef.addColumn('combined_metric', tde.Type.DOUBLE)#11
	tableDef.addColumn('urban_imperial', tde.Type. DOUBLE)#12
	tableDef.addColumn('extra_urban_imperial', tde.Type.DOUBLE)#13
	tableDef.addColumn('combined_imperial', tde.Type.DOUBLE)#14
	tableDef.addColumn('noise_level', tde.Type,DOUBLE)#15
	tableDef.addColumn('co2', tde.Type.INTEGER)#16
	tableDef.addColumn('co_emissions', tde.Type.INTEGER)#17
	tableDef.addColumn('fuel_cost_6000_miles', tde.Type.INTEGER)#18

	#step 3: Create the table in the image of the tabledef
	table = tdefile.addTable('Extract', tableDef)

#Step 4: Loop through the csv, grac all the data, put it into rows 
#and insert the rows into the table variable 
newrow = tde.Row(tableDef)
csvReader.next()
for line in csvReader:
	newrow.setCharString(1, str(line[1]))
	date = datetime.datetime.strptime(line[0],"%m/%d/%Y")
	newrow.setDate(0, date.year, date.month, date.day)
	newrow.setCharString(2, str(line[2]))
	newrow.setCharString(3, str(line[3]))
	newrow.setInteger(4, int(line[4]))
	newrow.setCharString(5, str(line[5]))
	newrow.setCharString(6, str(line[6]))
	newrow.setInteger(7, int(line[7]))
	newrow.setCharString(8, str(line[8]))
	newrow.setDouble(9, float(line[9]))
	newrow.setDouble(10, float(line[10]))
	newrow.setDouble(11, float(line[11]))
	newrow.setDouble(12, float(line[12]))
	newrow.setDouble(13, float(line[13]))
	newrow.setDouble(14, float(line[14]))
	newrow.setDouble(15, float(line[15]))
	newrow.setInteger(16, int(line[16]))
	newrow.setInteger(17, int(line[17]))
	newrow.setInteger(18, int(line[18]))
	table.insert(newrow)

#step 5: Close the tde
tdefile.close()









