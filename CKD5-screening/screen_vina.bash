#!/bin/bash
#This script will run a virtual screen with Vina
#This script should be in the parent directory with a conf.txt file, the protein
#target as a PDBQT file, the Vina program, and all ligands in a directory
#named Ligands, each with a name starting with "ligand," and in PDBQT format.
#cp *.pdbqt Ligands/
mkdir -p Results-Vina
cd Ligands/
for f in ligand*.pdbqt;do echo "Processing ligand $f "; vina --config ../conf.txt --ligand $f --out ../Results-Vina/$f --log ../Results-Vina/$f.txt; done
cd ../Results-Vina/
for f in ligand*.txt; do sed -n '1p;26p' $f > Best_$f; done
for f in Best*.txt; do paste -s $f >> Summary.txt; done
for f in ligand*.txt; do echo "$f">> namelist.txt; done
paste Summary.txt namelist.txt > name_summary.txt
echo "Summary of Binding Affinities" >> Summary_Final.txt
echo "compound name        predicted binding score" &>> Summary_Final.txt
awk '{print $6, " ", $3}' name_summary.txt >> final.txt
sort -n -k2 final.txt &>> Summary_Final.txt
rm Best* Summary.txt namelist.txt name_summary.txt final.txt
