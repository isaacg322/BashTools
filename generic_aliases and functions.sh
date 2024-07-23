# Get indexed header from file
colno () {
        file=${1}
        head -n 1 ${file} | tr "\t" "\n" | awk '{print NR,$0}'
}

# make -ltrh default when doing ls
alias lss="ls --color -ltrh"
