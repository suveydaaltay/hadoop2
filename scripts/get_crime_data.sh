#!/bin/bash

mkdir -p examples/data
cd examples/data || exit 1

if [ ! -f Chicago_Crimes.csv ]; then
    echo "================================================================================================================="
    echo "Get data from kaggle..."
    echo "================================================================================================================="
    kaggle datasets download -d currie32/crimes-in-chicago
    echo "================================================================================================================="
    echo "Unzip kaggle set..."
    unzip crimes-in-chicago.zip
    echo "================================================================================================================="
    echo "Verify word count for CSVs..."
    wc -l ./*.csv
    echo "================================================================================================================="
    echo "Combine CSVs..."
    header=$(head -n 1 Chicago_Crimes_2001_to_2004.csv)
    header="num${header}"
    echo "${header}" > Chicago_Crimes_Dirty.out && tail -n+2 -q ./*.csv >> Chicago_Crimes_Dirty.out
    echo "================================================================================================================="
    echo "Verify word count for combined..."
    wc -l ./*.out
    echo "================================================================================================================="
    echo "Removing null years..."
    awk -F"," '!($19 == "")' Chicago_Crimes_Dirty.out > Chicago_Crimes.csv
    echo "================================================================================================================="
    echo "Verify word count for cleaned data..."
    wc -l Chicago_Crimes.csv
    echo "================================================================================================================="
    echo "Removing unwanted data..."
    rm ./Chicago_Crimes_2*.csv ./*.out crimes-in-chicago.zip
    echo "================================================================================================================="
fi