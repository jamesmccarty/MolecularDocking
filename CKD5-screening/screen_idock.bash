#!/bin/bash
#This script will run a virtual screen with Vina
#This script should be in the parent directory with a conf.txt file, the protein
#target as a PDBQT file, the Vina program, and all ligands in a directory
#named Ligands, each with a name starting with "ligand," and in PDBQT format.
mkdir -p Results-iDock 
idock --config idock.conf 
cd  Results-iDock
awk -F "\"*,\"*" '{print $1,$3,$4}' log.csv > summary.txt 
cat summary.txt | (sed -u 1q; sort -n -k2) > Summary_Final.txt
rm summary.txt 
