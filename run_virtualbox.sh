#!/bin/bash

main(){
    clear
    echo "This is Virtal Box" 
    
    echo "#     #                                        ######           "     
    echo "#     # # #####  #    # #####   ##   #         #     #  ####  #    # "
    echo "#     # # #    # #    #   #    #  #  #         #     # #    #  #  #  "
    echo "#     # # #    # #    #   #   #    # #         ######  #    #   ##   "
    echo " #   #  # #####  #    #   #   ###### #         #     # #    #   ##   "
    echo "  # #   # #   #  #    #   #   #    # #         #     # #    #  #  #  "
    echo "   #    # #    #  ####    #   #    # ######    ######   ####  #    # "


    echo -en "Choose an option: \n 1: Start VirtualBox host \n 2: Stop VirtualBox host\n >> "
    read opt1
    if [ "$opt1" -eq 1 ]; 
    then
        echo -e "\nHere is the List of VirtualBox Hosts"
        VBoxManage list vms > vm
        i=1
        while read line; do echo "[$i] $line"; ((i++)); done  < vm
        echo -e "Choose Numbers of VM which you want to start (eg: 1 2 3) \n >> "
        read -a my_array
        for elem in ${my_array[@]}
        do
            host=$(sed "${elem}q;d" vm | cut -f 2 -d " ")
            VBoxManage startvm $host --type headless
            if [ $? -eq 0 ]
            then
                echo -e "\n $(sed "${elem}q;d" vm | cut -f 1 -d " ") is started \n"
            else 
                echo "Something Wrong"
            fi
        done
        recall_func
    elif [ $opt1 -eq 2 ];
    then
        echo -e "\n Here is the List of Running Hosts"
        VBoxManage list runningvms > vm_running
        j=1
        while read line; do echo "[$j] $line"; ((j++)); done < vm_running
        read -p "Choose the Number of VM hosts to shutdown (eg: 1 2 3 || * for All VMs) >> " host_shut
        for elem in ${host_shut[@]}
        do
            if [ "$host_shut" == "*" ] 
            then
                for i in $(awk '{print $1}' vm_running | sed 's/"//g') 
                do 
                    VBoxManage controlvm $i poweroff
                done
                recall_func
            fi
            host=$(sed "${elem}q;d" vm_running | cut -f 2 -d " ")
            VBoxManage controlvm $host poweroff
            if [ $? -eq 0 ]
            then
                echo -e "\n $(sed "${elem}q;d" vm_running | cut -f 1 -d " ") is Poweroff \n"
            else
                echo "Something Wrong"
            fi
        done
        recall_func
    else
        exit 0
    fi
}
 
recall_func() {
    read -p "Do you want to try again?(Y/n):  " key_try
    if [ "$key_try" == "" ] || [ $key_try == "Y" ] || [ $key_try == "y" ] ; then
        main
    elif [ $key_try == "n" ] || [ $key_try == "N" ]; then
        exit 0
    else
        echo -e "Invalid Input!! \n Bye! Bye!" && exit 1
    fi
}

main
