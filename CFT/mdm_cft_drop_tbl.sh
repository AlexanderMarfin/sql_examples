#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] 
then 
	echo "Usage: <DB User> <SIEBEL password> <Environment (DEV|K1|K2|K3|K4|K6|PROD)> "
	exit 1
fi

	# set environment
	environment="$3"
	DBpass="$2"
	
	
	#проверка среды
	case "$environment" in
		DEV)
		ORACLE_HOME=/opt/oracle/client         # Oracle home, wrom which SQL Loader 10.2.0.4 is running 
		TNS_ADMIN=/opt/oracle/client/network/admin      # Place, where tnanames.ora with connection information is stored
		TNS="SIEBEL264"             # TNS Alias
		;;                                                                    
		K1)                                                                   
		ORACLE_HOME=/u01/app/oracle/client        # Oracle home, wrom which SQL Loader 10.2.0.4 is running 
		TNS_ADMIN=/u01/app/oracle/client/network/admin     # Place, where tnanames.ora with connection information is stored
		TNS="SIEBEL"              # TNS Alias
		;;                                                                    
		K2)                                                                   
		ORACLE_HOME=/u01/app/oracle/client        # Oracle home, wrom which SQL Loader 10.2.0.4 is running 
		TNS_ADMIN=/u01/app/oracle/client/network/admin     # Place, where tnanames.ora with connection information is stored
		TNS="K2MDM"              # TNS Alias
		;;                                                                    
		K3)                                                                   
		ORACLE_HOME=/u01/app/oracle/11.2.0/client      # Oracle home, wrom which SQL Loader 10.2.0.4 is running 
		TNS_ADMIN=/u01/app/oracle/11.2.0/client/network/admin   # Place, where tnanames.ora with connection information is stored
		TNS="K3MDM"              # TNS Alias
		;;                                                                    
		K4)                                                                   
		ORACLE_HOME=/u01/app/oracle/client        # Oracle home, wrom which SQL Loader 10.2.0.4 is running 
		TNS_ADMIN=/u01/app/oracle/client/network/admin     # Place, where tnanames.ora with connection information is stored
		TNS="K4MDMCH"              # TNS Alias
		;;                                                                    
		K6)                                                                   
		ORACLE_HOME=/u01/app/oracle/client        # Oracle home, wrom which SQL Loader 10.2.0.4 is running 
		TNS_ADMIN=/u01/app/oracle/client/network/admin     # Place, where tnanames.ora with connection information is stored
		TNS="K6MDM"              # TNS Alias 
		;;   
		K10)                                                                 
		ORACLE_HOME=/u01/app/oracle/product/11.2.0/client_1     # Oracle home, wrom which SQL Loader 10.2.0.4 is running 
		TNS_ADMIN=/u01/app/oracle/product/11.2.0/client_1/network/admin  # Place, where tnanames.ora with connection information is stored
		TNS="K10MDMCH"              # TNS Alias
		;;    
		PROD)                                                                 
		ORACLE_HOME=/u01/app/oracle/product/11.2/client     # Oracle home, wrom which SQL Loader 10.2.0.4 is running 
		TNS_ADMIN=/u01/app/oracle/product/11.2/client/network/admin  # Place, where tnanames.ora with connection information is stored
		TNS="MDMCH"              # TNS Alias
		;;
		*)
		echo "Incorrect Environment"
		echo "Usage: <DB User> <SIEBEL password> <Environment (DEV|K1|K2|K3|K4|K6|PROD)>"
		#exit 3
	;;
	esac
PATH=$ORACLE_HOME/bin:$PATH;
export ORACLE_HOME TNS_ADMIN PATH;
NLS_LANG=.AL32UTF8 ; export NLS_LANG;
#Step 1 Drop DROP_LOG_TABLE.sql
echo "Step 1 Execute DROP_LOG_TABLE.sql"
echo exit | sqlplus -L $1/$DBpass@$TNS @DROP_LOG_TABLE.sql
if [ "$?" == "1" ]
then
    echo "_____________________________"
	echo "ERROR! DROP_LOG_TABLE.sql failed!"
    echo "_____________________________"
	exit 1
else
    echo "_____________________________"
	echo "SUCCESS! DROP_LOG_TABLE.sql completed!"
    echo "_____________________________"

fi

#Step 2 Execute DROP_TEMP_TABLE.sql
echo "Step 2 Execute DROP_TEMP_TABLE.sql"
echo exit | sqlplus -L $1/$DBpass@$TNS @DROP_TEMP_TABLE.sql
if [ "$?" == "1" ] 
then
    echo "_____________________________"
	echo "ERROR! DROP_TEMP_TABLE.sql failed!"
    echo "_____________________________"
	exit 1
else
    echo "_____________________________"
	echo "SUCCESS! DROP_TEMP_TABLE.sql completed!"
    echo "_____________________________"

fi

echo "_____________________________"
echo "CONGRATULATION!"
echo "_____________________________"
exit 0;