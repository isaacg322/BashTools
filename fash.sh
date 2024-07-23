## Single liner to start an interactive job with  N memory and X cores

# Copy this inside ~/.bash_profile (or equivalent) inside an HPC system
# update queue names accordint to the system
# include project name were necessary 
function fash() {
        if [[ -z $1 ]]; then
                echo "fash 20 long 8";
                echo "fash 20 rhweek";
                echo "fash 20";
                echo "fash";
                return;
        fi;
        local memGB=${1:-5};
        local memMB=${memGB}000;
        local queue=${2:-long};
        local n=${3:-1};
        date;
        echo "starting interactive shell on $queue with $memGB GB ($memMB MB asked)";
        cmd="bsub -n$n -R'span[hosts=1]' -Is -q $queue -R'select[mem>$memMB] rusage[mem=$memMB]' -M$memMB bash";
        echo $cmd;
        eval $cmd
}
