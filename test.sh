#Usage: bash test.sh

#1) Put all the mcrA gene files into one single file:
cat bioinformatics_project2019/ref_sequences/mcrAgene_*.fasta >> mcrAgene.fasta

#Put all the HSP gene files into one single file:
cat bioinformatics_project2019/ref_sequences/hsp70gene_*.fasta >> hsp70gene.fasta

#2) use Muscle to make alignment of those genes:
./muscle -in mcrAgene.fasta -out mcrAgeneAlign.fasta
./muscle -in hsp70gene.fasta -out hsp70geneAlign.fasta

#3)hmmbuild: align in hmm out:
./hmmer/bin/hmmbuild mcrAgeneHMM mcrAgeneAlign.fasta
./hmmer/bin/hmmbuild hsp70geneHMM hsp70geneAlign.fasta

#4)hmmsearch: find and match:
for file in bioinformatics_project2019/proteomes/proteome_*.fasta
do
  name=$(echo $file | cut -d '/' -f 3 | cut -d '.' -f 1)
  ./hmmer/bin/hmmsearch --tblout $name"_mcrA" mcrAgeneHMM $file
  ./hmmer/bin/hmmsearch --tblout $name"_hsp70" hsp70geneHMM $file
done

#5)Create table of outputs
echo -e "Proteome name\t\tHas mcrA gene? (1 = yes, 0 = no)\t\tNumber of hsp70 gene matches" > proteomeMatch.txt
for file in proteome_*_hsp70
do
  name=$(echo $file | cut -d '_' -f1,2)
  mcrA=$(grep -c "WP_" $name"_mcrA")
  hsp70=$(grep -c "WP_" $file)
  echo -e "$name\t\t$mcrA\t\t\t$hsp70" >> proteomeMatch.txt
done


#6)Create text file with candidate pH-resistant methanogens
grep -P "\t0" -v proteomeMatch.txt | sort -t\t -k3 >> candidate_proteomes.txt
