# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setname.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rsilva <rsilva@student.42.us.org>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/04/03 00:31:15 by rsilva            #+#    #+#              #
#    Updated: 2018/04/03 00:31:21 by rsilva           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Version: Beta af lol (0.9.0)
# if you find bugs or wanna say hi slack me @rsilva
# thank you for bearing with this primitive program
# I hope to improve some things when I have the time to
# Good luck on your projects and may you find whatever it is you seek :D

if [ $# -lt 1 ] || [ $# -gt 6 ] || [ $1 = "-help" ] || [ $1 = "-h" ]
then
	tabs -6
	echo "Usage: nameset [-P] [-c <color number>] name [-l <length>]\n"
	echo "Help: Setname changes the terminal prompt."
	echo "	By default, the text will be set to terminal grey (007)."
	echo "	Please make sure your prompt looks dope."
	echo "Options:"
	echo "	-P		Sets change to the .zshrc file. (overwrites last occurrence of 'PS1')"	
	echo "	-c		Takes in three digit color format (see color sheet for colors)."
	echo "	-l		Manually sets length (avoids visual glitches when using special characters)."
	tabs
	return
fi

if [ $1 = "-P" ]
then
	isperm=1
	shift
else
	isperm=0
fi

if [ $1 = "-c" ]
then
	if [ ${#2} -ne 3 ]
	then
		echo "Enter color in three digit format (see color sheet for colors)."
		return
	else
		color="$2"
	fi
	shift
	shift
else
	color=007
fi

name=$1
shift

if [ $# -gt 0 ]
then
	if [ $1 = "-l" ]
	then
		if [ ${#2} -lt 1 ]
		then
			echo "Enter character length of name (some characters take up extra space)"
			return
		else
			length="$2"
		fi
		shift
		shift
	fi
else
	length=-1
fi

if [ -n "$length" ] && [ $length -ne -1 ]
then
	newname="%${length}{$(echo -e "\e[38;5;${color}m${name}\e[0m")%}"
else
	newname="%${#${name}}{$(echo -e "\e[38;5;${color}m${name}\e[0m")%}"
fi

if [ $isperm = 1 ]
then
	gone=${#$(grep "^PS1" ~/.zshrc)}
	if [ $gone -lt 1 ]
	then
		echo "PS1=\"${newname}\"" >> ~/.zshrc
	else
		sed -i -e "s/^PS1=.*/PS1=\"${newname}\"/" ~/.zshrc
	fi
	source ~/.zshrc
else
	export PS1="$newname"
fi
return
