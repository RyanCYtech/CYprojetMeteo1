#!/bin/bash

while [[ $# -gt 0 ]]; do
    case $1 in
        -t1)
            T1=true
            Type=true
            shift
            ;;
        -t2)
            T2=true
            Type=true
            shift
            ;;
        -t3)
            T3=true
            Type=true
            shift
            ;;
        -p1)
            P2=true
            Type=true
            shift
            ;;
        -p2)
            P2=true
            Type=true
            shift
            ;;
        -p3)
            P2=true
            Type=true
            shift
            ;;
        -w)
            Type=true
            W=true
            shift
            ;;
        -h)
            Type=true
            H=true
            shift
            ;;
        -m)
            Type=true
            M=true
            shift
            ;;
        -F|-G|-S|-A|-O|-Q)
            if [[ ${loc} ]]; then
                echo "One location"
                exit 1
            fi
            loc=true
            if [[ ${1} == "-F" ]]; then
                F=true
            fi
            if [[ ${1} == "-G" ]]; then
                G=true
            fi
            shift
            ;;
        -d)
            dmin="$2"
            dmax="$3"
            shift
            shift
            shift
            ;;
        --tab|--abr|--avl)
            if [[ ${sort} ]]; then
                echo "One sort mode"
                exit 1
            fi
            sort="$1"
            shift
            ;;
        -f)
            input="$2"
            shift
            shift
            ;;
        *)
            echo "Unknown option $1"
            exit 1
            ;;
    esac
done

if [[ ${T} && -z ${TMode} ]]; then
    echo "No mod"
    exit 1
elif [[ ${P} && -z ${PMode} ]]; then
    echo "No mod"
    exit 1
fi
if [[ -z ${Type} ]]; then
    echo "No type"
    exit 1
fi
if [[ -z ${input} ]]; then
    echo "No input file"
    exit 1
fi

if ! [[ -f "Main" ]]; then
    make
fi


if [[ ${H} ]]; then
    rm -f temp.txt
    awk -F "\"*;\"*" '
    {
        if (NR!=1) {
            if ($F) {
                if ($10 < 41 || $10 > 52 || $11 < -5 || $11 > 10) {
                    next;
                }
            }
            if ($14) {
                print $14";"$14";"$10 > "temp.txt";
            }
        }
    }' "$input"
    ./Main -f "temp.txt" -o "output.txt" -r
    if [[ $(echo $?) == 0 ]]; then
        echo 'set terminal png
        set output "height.png"
        set datafile separator ";,"
        set border 4095 front lt black linewidth 1.000 dashtype solid
        set title "Height of stations"
        set style data lines
        set xlabel "Latitude"
        set ylabel "Longitude"
        set dgrid3d 20,20,10
        set pm3d map
        set palette rgb 21,22,23
        splot "output.txt" using 1:2:3' >> gnutest
        gnuplot --persist gnutest
        rm gnutest
    fi
fi

if [[ ${M} ]]; then
    rm -f temp.txt
    awk -F "\"*;\"*" '
    {
        if (NR!=1) {
            if ($F) {
                if ($10 < 41 || $10 > 52 || $11 < -5 || $11 > 10) {
                    next;
                }
            }
            if ($5) {
                print $5";"$5";"$10 > "temp.txt";
            }
        }
    }' "$input"
    ./Main -f "temp.txt" -o "output.txt" -r
    if [[ $(echo $?) == 0 ]]; then
        echo 'set terminal png
        set output "moisture.png"
        set datafile separator ";,"
        set title "Moisture of stations"
        set style data lines
        set xlabel "Latitude"
        set ylabel "Longitude"
        set border 4095 front lt black linewidth 1.000 dashtype solid
        set dgrid3d 40,40,10
        set pm3d map
        set palette rgb 21,22,23
        splot "output.txt" using 1:2:3' >> gnutest
        gnuplot --persist gnutest
        rm gnutest
    fi

fi

if [[ ${W} ]]; then
    rm -f temp.txt
    awk -F '[;,]' '
    {
        if (NR!=1) {
            if ($F) {
                if ($10 < 41 || $10 > 52 || $11 < -5 || $11 > 10) {
                    next;
                }
            }
            if ($5) {
                print $1";"$4";"$5";"$10";"$11 > "temp.txt";
            }
        }
    }' "$input"
    ./Main -f "temp.txt" -o "output.txt"
    if [[ $(echo $?) == 0 ]]; then
        echo 'set terminal png
        set datafile separator ";"
        set output "Graphe.png"
        set title "Graphe"
        set style data points
        set angles degrees
        set xlabel "Longitude"
        set ylabel "Latitude"' >> gnutest
        echo "plot  '"output.txt"' using 3:4:"'(($2*1.5)*cos($1)):(($2*1.5)*sin($1))'" with vector" >> gnutest
        gnuplot --persist gnutest
        rm gnutest
    fi

fi

rm -f temp.txt
#display *.png


for file in *
do
  if [ -f $file ]; then
    # Check if file is an image
    file_extension="${file##*.}"
    if [[ $file_extension =~ ^(png)$ ]]; then
      echo "Displaying image: $file"
      display $file
    fi
  fi
done



