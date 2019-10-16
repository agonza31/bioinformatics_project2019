# Usage: bash

#sort out the candidates: the presence of the methyl-coenzyme M reductase (McrA) gene& more copies of HSP70 gene

#Your script should include all of the necessary steps to search each genome for the genes of interest and should produce a summary table collating the results of all searches. 

#1) Put all the mcrA gene files into one single file:
cat /afs/crc.nd.edu/user/y/yzhang49/Exercise-06/bioinformatics_project2019/ref_sequences/mcrAgene_*.fasta >> /afs/crc.nd.edu/user/y/yzhang49/Exercise-06/bioinformatics_project2019/ref_sequences/mcrAgene.fasta

#Put all the HSP gene files into one single file:
cat /afs/crc.nd.edu/user/y/yzhang49/Exercise-06/bioinformatics_project2019/ref_sequences/hsp70gene_*.fasta >> /afs/crc.nd.edu/user/y/yzhang49/Exercise-06/bioinformatics_project2019/ref_sequences/hsp70gene.fasta

#2) use Muscle to make alignment of those genes:
/afs/crc.nd.edu/user/y/yzhang49/muscle -in /afs/crc.nd.edu/user/y/yzhang49/Exercise-06/bioinformatics_project2019/ref_sequences/mcrAgene.fasta -out /afs/crc.nd.edu/user/y/yzhang49/Exercise-06/bioinformatics_project2019/ref_sequences/mcrAgeneAlign.fasta
/afs/crc.nd.edu/user/y/yzhang49/muscle -in /afs/crc.nd.edu/user/y/yzhang49/Exercise-06/bioinformatics_project2019/ref_sequences/hsp70gene.fasta -out /afs/crc.nd.edu/user/y/yzhang49/Exercise-06/bioinformatics_project2019/ref_sequences/hsp70geneAlign.fasta

#3)hmmbuild: align in hmm out:
/afs/crc.nd.edu/user/y/yzhang49/hmmer-3.2.1/bin/hmmbuild /afs/crc.nd.edu/user/y/yzhang49/Exercise-06/bioinformatics_project2019/ref_sequences/mcrAgeneHMM /afs/crc.nd.edu/user/y/yzhang49/Exercise-06/bioinformatics_project2019/ref_sequences/mcrAgeneAlign.fasta
/afs/crc.nd.edu/user/y/yzhang49/hmmer-3.2.1/bin/hmmbuild /afs/crc.nd.edu/user/y/yzhang49/Exercise-06/bioinformatics_project2019/ref_sequences/hsp70geneHMM /afs/crc.nd.edu/user/y/yzhang49/Exercise-06/bioinformatics_project2019/ref_sequences/hsp70geneAlign.fasta

#4)hmmsearch: find and match:
/afs/crc.nd.edu/user/y/yzhang49/hmmer-3.2.1/bin/hmmsearch /afs/crc.nd.edu/user/y/yzhang49/Exercise-06/bioinformatics_project2019/ref_sequences/mcrAgeneHMM /afs/crc.nd.edu/user/y/yzhang49/Exercise-06/bioinformatics_project2019/proteomes/proteome_$@.fasta
/afs/crc.nd.edu/user/y/yzhang49/hmmer-3.2.1/bin/hmmsearch /afs/crc.nd.edu/user/y/yzhang49/Exercise-06/bioinformatics_project2019/ref_sequences/hsp70HMM /afs/crc.nd.edu/user/y/yzhang49/Exercise-06/bioinformatics_project2019/proteomes/proteome_$@.fasta 



