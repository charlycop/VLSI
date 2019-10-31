#!/bin/bash

fichier='annale'
testbench='testbenchannale'
etoiles='***********************'
clear 

echo "${etoiles}"
echo "ghdl -a -v ${fichier}.vhdl"
echo "${etoiles}"
ghdl -a -v ${fichier}.vhdl
read -p "Appuyer sur une touche pour continuer ..."
echo "${etoiles}"
echo "ghdl -a -v ${testbench}.vhdl"
echo "${etoiles}"
ghdl -a -v ${testbench}.vhdl
read -p "Appuyer sur une touche pour continuer ..."
echo "${etoiles}"
echo "ghdl -e -v ${testbench}"
echo "${etoiles}"
ghdl -e -v ${testbench}
read -p "Appuyer sur une touche pour continuer ..."
echo "${etoiles}"
echo "ghdl -r ${testbench} --vcd=${fichier}.vcd"
echo "${etoiles}"
ghdl -r ${testbench} --vcd=${fichier}.vcd

echo "${etoiles}"
echo "ENJOY :)"

read -p "Appuyer sur une touche pour terminer ..."
gtkwave ${fichier}.vcd
