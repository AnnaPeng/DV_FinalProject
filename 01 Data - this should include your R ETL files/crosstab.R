KPI_Low_Max_value = 26
KPI_Medium_Max_value = 32

#df <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest#/native/?query=
#  "select manufacturer, year, combined_metric, transmission_type, kpi as ratio, 
#   case

#       when kpi < "p1" then \\\'03 Low\\\'

#       when kpi < "p2" then \\\'02 Medium\\\'
       
#       else \\\'01 High\\\'

#       end kpi

#       from (select manufacturer, year, 

#       combined_metric, transmission_type, 

#       combined_metric as kpi

#       from carconsump)

#       order by manufacturer;"    

#      ')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_pp9774', PASS='orcl_pp9774', 
                        
#                        MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1=KPI_Low_Max_value, p2=KPI_Medium_Max_value, verbose = TRUE)))

CAR_CONSUMP <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from carconsump"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_pp9774', PASS='orcl_pp9774', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

df <- CAR_CONSUMP %>% group_by(MANUFACTURER) %>% mutate(KPI = ifelse(COMBINED_IMPERIAL <= KPI_Low_Max_value, '03 Low', ifelse(COMBINED_IMPERIAL <= KPI_Medium_Max_value, '02 Medium', '01 High')))