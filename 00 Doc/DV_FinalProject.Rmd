---
title: Final Project -- Exploring Automobile's Fuel Efficiency & Environmental-Friendliness
data: UK Car Fuel Consumption and Emissions 
author: "Panyu Peng; Bryan Ho" 
date: "December 4, 2015"  
output: html_document 
---
![](c.png)

#Today, we are exploring myriad elements of automobiles including Fuel Type, Transmission Type, Engine, Manufacturer etc. so that we have an idea of the optimal combination of these elements that makes the most fuel efficient and environmental-friendly transportation tool. 

1. <span style="color:red">Non-Aggregated Measures Analysis</span> 
2. <span style="color:red">Aggregated Measures Analysis</span> 
3. <span style="color:red">Scatter Plots</span> 
4. <span style="color:red">Crosstabs</span>  
5. <span style="color:red">Barcharts</span> 

#Create a Table and upload data to Oracle Server. The modified versions are as follows:
##UK Car Fuel Consumption and Emissions's R_ETL.R file and Table:  
![](CSV.png)  

CREATE TABLE carconsump (
-- Change table_name to the table name you want.
year varchar2(4000),
manufacturer varchar2(4000),
model varchar2(4000),
engine varchar2(4000),
transmission varchar2(4000),
transmission_type varchar2(4000),
fuel_type varchar2(4000),
X varchar2(4000),
X_1 varchar2(4000),
X_2 varchar2(4000),
X_3 varchar2(4000),
X_4 varchar2(4000),
X_5 varchar2(4000),
X_6 varchar2(4000),
X_7 varchar2(4000),
X_8 varchar2(4000),
X_9 varchar2(4000),
euro_standard number(38,4),
engine_capacity number(38,4),
urban_metric number(38,4),
extra_urban_metric number(38,4),
combined_metric number(38,4),
urban_imperial number(38,4),
extra_urban_imperial number(38,4),
combined_imperial number(38,4),
noise_level number(38,4),
co2 number(38,4),
co_emissions number(38,4),
fuel_cost_6000_miles number(38,4)
);

 
#Experiment Tableau Data Extract
##I extracted the first 5000 thousand rows of our dataset, carconsump.reformatted.csv of total of 10,000 rows and save it as a .tde called carconsump.reformatted_5000Rows.tde. So I created a TDE from a CSV from Tableau user interface. Follows are the procedures to create a TDE:
![](ExperimentExtractData.png)
![](ExpExtractData_5000.png)

#Understand Tableau Data Extract

##A Tableau data extract is a compressed snapshot of data stored on disk and loaded into memory as required to render a Tableau viz.There are two aspects of TDE design that make them ideal for supporting analytics and data discovery. 
##The first is that a TDE is a columnar store. Columnar databases store column values together rather than row values, and as a result, they dramatically reduce the input/output required to access and aggregate the values in a column. 
![](Col_Row.png)

##The second key aspect of TDE design is how they are structured which impacts how they are loaded into memory and used by Tableau.TDEs use all parts of your computer’s memory, from RAM to hard disk, and put each part to work as best fits its characteristics. To better understand, I tried to connect to our data UK Car Fuel Consumptions and Emissions with an Extract API script in python, where I explored and walked through how a TDE is created from a CSV and then later used in our project as the data source for one or more visualizations.
![](PythonCSV2TDE.png)
##When Tableau creates a data extract, it first defines the structure for the TDE and creates separate files for each column in the underlying source.To complete the creation of a TDE, individual column files are combined with metadata to form a memory-mapped file. Because a TDE is a memory-mapped file, when Tableau requests data from a TDE, the data is loaded directly into memory by the operating system. Tableau doesn’t have to open, process or decompress the TDE to start using it. If necessary, the operating system continues to move data in and out of RAM to insure that all of the requested data is made available to Tableau. This is a key point - it means that Tableau can query data that is bigger than the available RAM on a machine!

###For further information on TDE, check 
<a href="http://www.tableau.com/about/blog/2014/7/understanding-tableau-data-extracts-part1/">Tableau Understanding Data Extracts</a>

#Explore Tableau Data Visualizations!

##<span style="color:red">Non-Aggregated Measures Analysis</span>(start with a green thing) - also demonstrates Boxplots, Detail, and Pages
##Boxplot Story (start with a green thing)
###1. Open UK Car Consumption and Emissions. tde

###2. Uncheck Aggregate Measures under the Analysis tab and Rename the Current Sheet to Co2 Emissions Boxplot.

###3. Click on Co2 Under Measures and then click on the boxplot icon on "Show Me” i.e., the right icon on row 7.

###4. Drag Fuel Type onto Columns.

###5. Drag Manufacturer onto the Color Shelf.

###6. Drag Manufacturer onto the Filters Shelf and from this Pill's menu, select Show Quick Filter.

###7. Drag Engine onto Detail
![](Boxplot1.png)

###8. Drag Manufacturer onto Pages

###9. Filtered out the top 20 luxury cars

###10. Click through the luxury car brands on Pages 
###Entry-Level Luxury Cars
The main fuel type used by this group of cars with price rage $ 30,000 - $ 150,000 are Diesel and Petrol. If using Deisel, Mercedez-Benz, Audi, BMW, Jaguar and other except Land Rover has mean carbon emissions between 150 - 200 grammes per kilometre (g/km). If using Petrol, Mercedez-Benz, Audi, BMW have average near 200 grammes per kilometre (g/km). The worst performing manufacturer is Land Rover which has mean Co2 emissions up to 350 grammes per kilometre (g/km).
![](Merc.png)
![](Audi.png)
![](BMW.png)
![](Jag.png)
![](Cad.png)
![](Lex.png)
![](Por.png)
![](Land.png)

###Premium Luxury Brands
Interestingly, top luxury car manufacturers such as Maserati, Lamborghini, Rolls-Royce, Ferrari, and Aston Martin Lagonda can only use one fuel type Petrol. Highest mean Co2 emission -- Lamborghini up to 600 (g/km). 
![](Mas.png) 
![](Lam.png)
![](Lam.png)
![](Rolls.png)
![](Fer.png)
![](Ast.png)

If we plot out the boxplot of luxury cars' Co2 emissions and Noise level, we see that the avaerage of Co2 emissions is around 211 g/km, and average of Noise level is up to 71 measured on the A scale of a noise meter (dB (A)).
![](Noi.png)

Why luxury cars have high emissions and high noise level? I can't quite imagine a sports car with a V12 engine and maximum speed of 350kph having an emissions/ noise level bypass. Fortunately not everyone can afford one. Good news to our Earth!

##<span style="color:red">Scatterplot on Shiny App </span>  
##First thing to do
![](uiPACKAGES.png)
![](serverPACKAGES.png)
  
##Scatterplot: Engine Capacity Vs. Combined Imperial  
![](ShinyScatterplot.png)  
  
##In this scatterplot tab, we added some useful features.  
##Below here are the codes that we used to generate these features.  

![](partUI.png)
![](part1SERVER.png)
![](part2SERVER.png)  
  
###Conclusion: The more engine capacity the car has, the less miles averages that car can drive per gallon. Also, if we take a look at the scatterplot in every year, we can see that the gas efficiency has increased from around 30 mpg to 45 mpg.
  
##Below Here is the link to our shiny app  
https://bryanho.shinyapps.io/04Shiny  

##<span style="color:red">Scatter Plots</span> (start with 2 green things) -also demonstrates the Trend Line - Models and Forecasting

##Scatterplot Story
##1. Drag Urban Imperial to Column and Co2 to Row, and drag

##2. Right click the scatterplot to find Trend Line, click edit trend line and choose logarithmic model type
![](s.png)
##3. Describe Trend Model
![](d.png)
![](des.png)
Urban-Imperial here defines fuel consumption in miles per gallon (mpg). The scatterplot hints a logarithmic model type with model formula: Fuel Type*( log(Urban Imperial) + intercept ). It shows that the more miles sustained by a gallon, the fewer Co2 emissions by this car. That is the more efficient the engine or the fuel, the less Co2 pruduced. Get #97 for your car!

##<span style="color:red">Aggregated Measures Analysis</span>(start with a green thing) - also demonstrates Histograms, Reference Lines, Sets, Dual-axis Plots and Show Me
##Histogram Story (start with a green thing) + Reference Lines + Sets
##1. Open UK Car Consumption and Emission Extract.tde

##2. Rename Sheet 1 to Noise Level Histogram

##3. Drag Engine to Column, and Noise Level to Row

##4. Take Average as the Measure of Noise Level

##5. Drag Noise Level to Filter and click Show Quick Filter
![](EngHis.png)

##6. Adjust filter to find the Engine gives highest average of noise level
![](High.png)

##7. Adjust filter to find the Engine that gives lowest average of noise
![](Low.png)
Upper 70s (dB (A)) are annoyingly loud to some people. So next I compare the Average of the all the Noise made by these engines to the threshold 70s (dB (A)).

##8. Go to Analytics and click Reference Line, choose Line Only. Click on Value and choose create parameter. Created a parameter called "Annoyingly Loud", and click OK. And then go to Analytics and click Average Line.
![](Refline.png)
Clearly the Average noise made by all these years from 2000 to 2013 have surpassed the standards of human comfort.

##9.Select the four highest Sales Categories and hover over one of them. Click on the Set icon and select Create Set. Name the Set “Four Highest Noise Levels”
![](f.png)

##More Histogram Story
##CNT of Cost of Fuel 6000 Miles with SUM of Engine Capacity on a Dual-axis
##1. Drag the Measure Fuel Cost 6000 miles to "Drop to the field" and click Histogram on "Show Me"

##2. Drag Engine Capacity to right axis to create a dual axis plot

##3. Go to Makr, click on CNT(Fuel Cost 6000 Miles) and change Automatic to Bar, and then click on SUM(Engine Capacity) and change Automatic to Line	
![](dual.png)
##4. Drag Year to Pages Shelf and step through each year from 2000 to 2004.
<video controls="controls" width="800" height="600" name="Dual Axis through Years" src="PagesoverYear.mov"></video>
It tells that over the four years the mean fuel cost to run 6000 miles in Pounds doesn not change, is always 540.5 Pounds; what changes is that over time, more and more people's cars have run 6000 miles and thus the counts for each variable in the bin is increasing. It reflects car has been becoming a popular travel tool. The yellow line also shows that the larger the engine capacity the higher fuel cost.

##The above can also be shown in Packed Bubble
![](Packed.png)
Step through each year from 2000 to 2004
<video controls="controls" width="800" height="600" name="Dual Axis through Years" src="Packedbubble.mov"></video>
  
##<span style="color:red">Crosstab on Shiny App</span> 
##CrossTab: Fuel Type Vs. Transmission Type  
![](ShinyCrossTab.png)
  
##Similar to the first scatterplot, here, we added some other useful features 
  
##Below Here are the codes that we used to generate this tab
  
###This is the UI code
![](uiCrossTab.png)  
  
###This is the SERVER code
![](codeserver.png)  
  
![](part2CSERVER.png)  
  
##Another interesting feature that we discovered  
![](CrossTabTable.png)
  
###Conclusion: Looking this crosstab, we see that the "Compressed Natural Gas (CNG)" has the most gas efficiency among the others. Also, If we take a look at the 2 Transmission types, Automatic and Manual, and make a comparison, we see that Manual tends to have a better gas efficiency than Automatic.
    
##Below Here is the link to our shiny app  
https://bryanho.shinyapps.io/04Shiny  
  
##<span style="color:red">Crosstabs</span> (start with two blue things and a green thing) - also demonstrates Key Performance Indicators (KPIs), Calculated Fields, Sets, Parameters, and Hierarchies
##Crosstabs + KPI Story + Sets (start with two blue things and a green thing)

##1. Open UK Car Consumption and Emissions Extract.tde
##2. Rename Sheet 1 to Crosstab + KPI
##3. Drag Fuel Type to the Columns Shelf
##4. Drag Manufacturer to the Rows Shelf
##5. Drag Co2 to Text on the Marks Card
##6. View the data by clicking on the View Data icon on the Dimensions Tab, notice there is no column named “KPI – Fuel Consump Ratio”
##7. On the Dimensions Tab, click on the menu icon and select Create Calculated Field
##8. Name the Calculated Field “KPI - Fuel Consummp Ratio”
##9. Enter Sum([Urban Imperial])/Sum([Co2]) as the calculation. Notice that Urban Imperial means fuel comsumption in urban conditions in miles per gallon (mpg). So the higher ratio the entry has, the more environmental-friendly and more fuel efficient the combo is
##10. On the Dimensions Tab, click the View Data icon and see that a new field named “KPI - Fuel Consump Ratio” was added to the data.
##11. View the data again, now notice there is a column named “KPI – Fuel Consump Ratio”
##12. Drag KPI - Fuel Consump Ratio onto Color
##13. Change the Color Palette to Red-White-Green Diverge. The greener the better. Also adjust to Entire View to see the entire crosstab
![](KPI.png)
Clearly all cars that use Diesel Electric Engine are green and therefore more environmental-freindly. However, there is no certain manufacturer whose cars are environmental-friendly over all Fuel Types. So my suggestion is that no matter what car you get, try using Diesel Electricity.
##14. Create a Four Highest Co2 Set, and drag it to Filters. Set this Filter to All.
![](set.png)
![](sf.png)
The numbers show that these four brands are pretty popular in UK so they have the highest sum of Co2 emissions; the color tells us that Mercedes-Benz and Volkswagen are more environmentally friedly (VW really?).
http://www.dw.com/en/vw-98000-petrol-cars-affected-by-co2-emissions-cheating-scam/a-18825262

##<span style="color:red">Barcharts</span> (start with a blue thing and a green thing) - also demonstrate Table Calculations

##Barcharts Story (start with a blue thing and a green thing) + Table Calculations

##1. Drag Year and Transmission Type to Rows, and Noise Level to Columns

##2. Exclude Null and N/A in the last year; Change SUM of Noise to AVE, and add an Average Reference Line

##3. Drag Co2 to Columns, and change SUM to AVE, and add a Average Reference Line

##4. Drag Combined Imperial to Column, and change SUM to AVE, and add Average Reference Line. 

##5. Add a KPI -- MPG/Co2g/kg. The higher the ratio, the more efficient and environmental-friendly
![](b.png)
Manual Transmission cars tend to be more fuel efficient and environmental-freindly 








