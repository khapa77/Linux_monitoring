#!/bin/bash

source ./add
source ./func
source ./colors

# Data:

H_N=`hostname`
tz="$(f_eqv "$(timedatectl show)" 2) UTC $(date +"%:z")"
US=`whoami`
os=$(f_eqv "$(cat /etc/os-release)" 10)
DT=`date | awk '{ print $2" "$3" "$4" "$5 }'`
UT=`uptime | awk '{ print $1 }'`
UT_S=`cut -d '.' -f1 /proc/uptime`
ip=`hostname -I`
mask=`ip a | grep "inet " | sed -n 2p | awk '{print $2}' | cut -d'/' -f2`
mask_full=$(p_2_m $mask)
gateway=`ip a | grep "inet " | sed -n 2p | awk '{print $4}'`
R_T=$(ram 2)
R_U=$(ram 3)
R_F=$(ram 4)
# Disk space
Sp_R=$(space 2)
Sp_U=$(space 3)
Sp_F=$(space 4)

# Export:

declare -A spec
keys=()
spec["HOSTNAME"]=$H_N
keys+=("HOSTNAME")
spec["TIMEZONE"]=$tz
keys+=("TIMEZONE")
spec["USER"]=$US
keys+=("USER")
spec["OS"]=$os
keys+=("OS")
spec["DATE"]=$DT
keys+=("DATE")
spec["UPTIME"]=$UT
keys+=("UPTIME")
spec["UPTIME_SEC"]=$UT_S
keys+=("UPTIME_SEC")
spec["IP"]=$ip
keys+=("IP")
spec["MASK"]=$mask_full
keys+=("MASK")
spec["GATEWAY"]=$gateway
keys+=("GATEWAY")
spec["RAM_TOTAL"]=$R_T
keys+=("RAM_TOTAL")
spec["RAM_USED"]=$R_U
keys+=("RAM_USED")
spec["RAM_FREE"]=$R_F
keys+=("RAM_FREE")
spec["SPACE_ROOT"]=$Sp_R
keys+=("SPACE_ROOT")
spec["SPACE_ROOT_USED"]=$Sp_U
keys+=("SPACE_ROOT_USED")
spec["SPACE_ROOT_FREE"]=$Sp_F
keys+=("SPACE_ROOT_FREE")


output_save spec 

