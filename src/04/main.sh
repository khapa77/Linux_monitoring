#!/bin/bash
# 1 — white, 2 — red, 3 — green, 4 — blue, 5 – purple, 6 — black
# Text  Fone
#  37 	47	white
#  31	41	red
#  32	42	green
#  34	44	blue
#  35	45	purple
#  30	40	black


#Column 1 background = default (black)
#Column 1 font color = default (white)
#Column 2 background = default (red)
#Column 2 font color = default (blue)

def_column1_background=2
def_column1_font_color=4
def_column2_background=5
def_column2_font_color=1

CONFIG_FILE="./main.conf"

load_config() {
	if [ -f "$CONFIG_FILE" ]; then
		echo "Загрузка .conf файла"
		source "$CONFIG_FILE"
	else
		echo "Default .conf"
		column1_background=$def_column1_background
		column1_font_color=$def_column1_font_color
		column2_background=$def_column2_background
		column2_font_color=$def_column1_font_color
	fi
}

load_config

case $column1_background in
         1)
                 fon=49 # Grey 47
                 ;;
         2)
                 fon=41
                 ;;
         3)
                 fon=42
                 ;;
         4)
                 fon=44
                 ;;
         5)
                 fon=45
                 ;;
         6)
                 fon=40
                 ;;
        esac

 case $column1_font_color in	
	 1)
		 col=37
		 ;;
	 2)
		 col=31
		 ;;
	 3)
		 col=32
		 ;;
	 4)
		 col=34
		 ;;
	 5)
		 col=35
		 ;;
	 6)
		 col=39 # 30
		 ;;
	esac

 case $column2_background in
         1)
                 fon2=49 # Grey 47
                 ;;
         2)
                 fon2=41
                 ;;
         3)
                 fon2=42
                 ;;
         4)
                 fon2=44
                 ;;
         5)
                 fon2=45
                 ;;
         6)
                 fon2=40
                 ;;
        esac

 case $column2_font_color in
         1)
                 col2=37
                 ;;
         2)
                 col2=31
                 ;;
         3)
                 col2=32
                 ;;
         4)
                 col2=34
                 ;;
         5)
                 col2=35
                 ;;
         6)
                 col2=39 # 30
                 ;;
        esac
# 1 — white, 2 — red, 3 — green, 4 — blue, 5 – purple, 6 — black
declare -A colors
keys2=()
colors["1"]="White"
keys2+=("1")
colors["2"]="Red"
keys2+=("2")
colors["3"]="Green"
keys2+=("3")
colors["4"]="Blue"
keys2+=("4")
colors["5"]="Purple"
keys2+=("5")
colors["6"]="Black"
keys2+=("6")

# colors-scheme !

color_scheme() {
    echo ""
    if [ -f "$CONFIG_FILE" ]; then
    echo "Column 1 background = $column1_background (${colors[$column1_background]})"
    echo "Column 1 font color = $column1_font_color (${colors[$column1_font_color]})"
    echo "Column 2 background = $column2_background (${colors[$column2_background]})"
    echo "Column 2 font color = $column2_font_color (${colors[$column2_font_color]})"
else
    echo "Column 1 background = default (${colors[$column1_background]})"
    echo "Column 1 font color = default (${colors[$column1_font_color]})"
    echo "Column 2 background = default (${colors[$column2_background]})"
    echo "Column 2 font color = default (${colors[$column2_font_color]})"
    fi

}

# colors-scheme _end

# Function_equal !
f_eqv() {
	local file="$1"
	local line="$2"

echo "$file" | awk '{ gsub("=", "\n") } 1' | sed -n "${line}p"
}
# Function_equal _end

# Prefix_to_mask !
p_2_m() {
    local prefix=$1
    local mask=""
    
    for i in $(seq 1 4); do 
# Команда seq генерирует последовательность чисел, 
# начиная с 1 и заканчивая 4. Это эквивалентно числам 1 2 3 4.
        if [ $prefix -ge 8 ]; then
            mask="$mask$((255))"
            prefix=$((prefix - 8))
        elif [ $prefix -gt 0 ]; then
            mask="$mask$((255 << (8 - $prefix) & 255))"
            prefix=0
        else
            mask="$mask$((0))"
        fi
        if [ $i -lt 4 ]; then
            mask="$mask."
        fi
    done

    echo $mask
}
# Prefix_to_mask _end

# RAM !
ram () {
	local val=$1
	rm=$(echo "scale=3; $(free -k | awk "NR==2 {print \$$val}") / 1024 / 1024" | bc)

if (( $(echo "$rm < 1" | bc -l) )); then
    rm="0$rm"
fi

echo "$rm GB"
}
# RAM _end

# Space !

space () {
	local val=$1
	sp=$(echo "scale=2; $(df / | awk "NR==2 {print \$$val}") / 1024" | bc)
if (( $(echo "$sp < 1" | bc -l) )); then
	sp="0$sp"
fi
echo "$sp MB"
}
# Space _end

# OUTPUT !
output_save (){
	local -n dist=$1
	local func=$2
if [ "$func" == "y" ]; then	
	local timestamp=$(date +"%d_%m_%y_%H_%M_%S")
        local filename="${timestamp}.status"

	for key in "${keys[@]}"; do
		echo "$key = ${dist[$key]}" >> "$filename"
	done
	echo "All data saved to: $filename" 
else
	for key in "${keys[@]}"; do
		echo -e "\e[${col};${fon}m$key \e[0m=\e[${col2};${fon2}m ${dist[$key]} \e[0m"
done
	fi	
}
# OUTPUT _end


# Data:

H_N=`hostname`
tz=$(f_eqv "$(timedatectl show)" 2)
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
echo ""
# Output data:

output_save spec 
color_scheme
