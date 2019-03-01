
#################################################
# Bash script - Modelo					#
# Use como modelo para criar seus scripts bash. #
# v_1.0.1							#
#################################################
VERSION=1.0


# FUNCAO cdw
function cdw(){

    case $1 in
		    "." )	
			    
			    pwd | tee | cat > ~/.workspace_rc
			    echo -en "\n\tGravado: $green $(pwd)$normal\n"

			    # tem que retornar um ponto, para que o cd permaneça no mesmo lugar.
			    #echo -en "."

		    ;;

		    "" )
			    if [ -e ~/.workspace_rc ]; then
				    WORK_DIR=$( cat ~/.workspace_rc )
				    if [ -n $WORK_DIR ]; then 
					  #echo $WORK_DIR
					  cd $WORK_DIR
				    else
					  echo NULO
				    fi
			    else
				  echo Nao existe o arquivo ~/.workspace_rc
				  cd ~/workspace
			    fi
		    ;;
    esac

}

