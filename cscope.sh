
LNX=/home/markuze/Projects/ubuntu-artful
KTCP=/home/markuze/Projects/ktcp_split
file="$CSCOPE_DB/cscope.files"

    find  $LNX                                                                	\
	-path "$LNX/arch/*" ! -path "$LNX/arch/x86*" -prune -o               	\
	-path "$LNX/include/asm-*" ! -path "$LNX/include/asm-generic*" -prune -o \
	-path "$LNX/tmp*" -prune -o                                           	\
	-path "$LNX/Documentation*" -prune -o                                 	\
	-path "$LNX/scripts*" -prune -o                                       	\
	-path "$LNX/drivers*" -prune -o                                       	\
	-path "$LNX/sound*" -prune -o                                       	\
	-path "$LNX/firmware*" -prune -o                                       	\
	-path "$LNX/tools*" -prune -o                                       	\
        -name "*.[chxsS]" -print > $file

    find $KTCP -name "*.[ch]" >> $file

    cd $CSCOPE_DB
    cscope -kqb
    ctags -L $file

