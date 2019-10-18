#Usage: bash test.sh

#1) Put all the mcrA gene files into one single file:
cat ./ref_sequences/mcrAgene_*.fasta > mcrAgene.fasta

#Put all the HSP gene files into one single file:
cat ./ref_sequences/hsp70gene_*.fasta > hsp70gene.fasta

#2) use Muscle to make alignment of those genes:
./muscle -in mcrAgene.fasta -out mcrAgeneAlign.fasta
./muscle -in hsp70gene.fasta -out hsp70geneAlign.fasta

#3)hmmbuild: align in hmm out:
./hmmer/bin/hmmbuild mcrAgeneHMM mcrAgeneAlign.fasta
./hmmer/bin/hmmbuild hsp70geneHMM hsp70geneAlign.fasta

#4)hmmsearch: find and match:
for file in ./proteomes/proteome_*.fasta
do
  name=$(echo $file | cut -d '/' -f 3 | cut -d '.' -f 1)
  ./hmmer/bin/hmmsearch --tblout $name"_mcrA" mcrAgeneHMM $file
  ./hmmer/bin/hmmsearch --tblout $name"_hsp70" hsp70geneHMM $file
done

#5)Create table of outputs
echo -e "Proteome ID\tmcrA\thsp70" > proteomeMatch.txt
for file in proteome_*_hsp70
do
  name=$(echo $file | cut -d '_' -f1,2) #Name of proteome (ex. Proteome_01)
  mcrA=$(grep -c "WP_" $name"_mcrA") #Number of mcrA hits
  hsp70=$(grep -c "WP_" $file) #Number of hsp70 hits
  echo -e "$name\t$mcrA\t$hsp70" >> proteomeMatch.txt
done


#6)Create text file with candidate pH-resistant methanogens
echo -e "Proteome ID\tmcrA\thsp70" > candidate_proteomes.txt
grep -P "\t0" -v proteomeMatch.txt | sort -k3nr | head -n -1 >> candidate_proteomes.txt #Proteomes sorted by # of hsp70 hits. More hsp70 hits = better candidate.
