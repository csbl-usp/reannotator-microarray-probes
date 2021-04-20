# reannotator_microarray_probes pipeline

Pipeline for microarray probes sequence reannotation.

## Summary
1. [Environment preparation](#environment-preparation)
2. [Clone a github repository](#clone-a-github-repository)
3. [Prepare human genome sequence and mapper index](#prepare-human-genome-sequence-and-mapper-index)
4. [Prepare GPL sequence file](#prepare-gpl-sequence-file)
5. [Execute the pipeline](#execute-the-pipeline)


## Environment preparation

### In your Terminal download the Miniconda installer
```
$ cd <specify a directory>
$ wget -O Miniconda3.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```
or you can use the curl command
```
$ curl -sL \
  "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" > \
  "Miniconda3.sh"
```

### Install the Miniconda by the command line:
```
$ bash Miniconda3.sh
```

### Conda installation process
```
Welcome to Miniconda3 py38_4.9.2

In order to continue the installation process, please review the license
agreement.
Please, press ENTER to continue
>>>

Do you accept the license terms? [yes|no]
[no] >>> yes

Miniconda3 will now be installed into this location:
/root/miniconda3

  - Press ENTER to confirm the location
  - Press CTRL-C to abort the installation
  - Or specify a different location below

[/root/miniconda3] >>> 
PREFIX=<Define your directory here!>

Do you wish the installer to initialize Miniconda3
by running conda init? [yes|no]
[no] >>> yes
```

### After installation, delete the installer:
```
rm Miniconda3.sh
```

**Important!!!** Close and open your terminal to activated the conda base environment.


### Update Conda using the command line:
```
$ conda update conda
```

### Finally, install the program wget and git using Conda to download any files using CLI:
```
$ conda install git
$ conda install wget
```

## Clone the reannotator github repository
```
$ git clone https://github.com/nicolau/reannotator_microarray_probes.git
```

### Entry on the source directory it contains all scripts
```
$ cd reannotator_microarray_probes/src/
```

### Change file permission for "execution" mode
```
$ chmod 755 *
```

### Build the conda environment for all required packages for the pipeline
```
$ conda env create --file ../parameters/reannotator_env.yml
$ conda activate reannotator
```
**Important!!!** Make sure the reannotator environment are active or execute the command 'conda activate reannotator'.


## Prepare human genome sequence and mapper index
### Build a human genome directory
```
$ ./createReferenceDirectory
```
The reference genome used for this pipeline is release-103 from ENSEMBL database.
**Under construction** How to change the human reference genome for newer or oldest version.

## Prepare GPL sequence file. Show a platforms structure with tree command:
```
$ tree ../platforms/
```

Strutucure of GPL directory.
```
../platforms/
|-- GPL10558
|   |-- probe_sequence.tsv
|-- GPL13287
|   |-- probe_sequence.tsv
|-- GPL13497
|   |-- probe_sequence.tsv
```

The content of probe_sequence.tsv should be "ID" and "SEQUENCE" columns.
```
$ head ../platforms/GPL10558/probe_sequence.tsv
```
```
"ID"    "SEQUENCE"
"ILMN_1343048"  "GAATAAAGAACAATCTGCTGATGATCCCTCCGTGGATCTGATTCGTGTAA"
"ILMN_1343049"  "CCATGTGATACGAGGGCGCGTAGTTTGCATTATCGTTTTTATCGTTTCAA"
"ILMN_1343050"  "CCGACAGATGTATGTAAGGCCAACGTGCTCAAATCTTCATACAGAAAGAT"
"ILMN_1343052"  "TCTGTCACTGTCAGGAAAGTGGTAAAACTGCAACTCAATTACTGCAATGC"
"ILMN_1343059"  "CTTGTGCCTGAGCTGTCAAAAGTAGAGCACGTCGCCGAGATGAAGGGCGC"
"ILMN_1343061"  "AATTAAAACGATGCACTCAGGGTTTAGCGCGTAGACGTATTGCATTATGC"
"ILMN_1343062"  "GAAGCATTCAGAGCAAATGAGGCAGCGTTGGTGTAGCACGATAATAATAT"
"ILMN_1343063"  "CGGACGTTATGATTTACCGTGGAAAGATTTGTGAAGTGTTCTGAATGCTC"
"ILMN_1343064"  "GCCCCGTATTCAGTGTGGCTGATTTGTATTGTCAGAAGTTGTTTTTACGT"
```

Based on existent platforms directories, create a new directories for newer platforms.

## To start all processes to reannotation of each probes, execute the pipeline
```
$ ./pipeline
```

## The results of output Reannotation are stored in all_annotated_probes.tsv file!
```
$ head ../results/all_annotated_probes.tsv
```
```
ProbeID Symbol  EnsemblIDs      Biotypes2       Biotypes1       Symbols
ILMN_1799969    SNAPIN  ENSG00000143553|ENST00000462880 protein_coding|processed_transcript     gene|lnc_RNA    SNAPIN|SNAPIN-202
ILMN_1783231    PLEKHB1 ENSG00000021300|ENST00000426191|ENST00000544282 protein_coding|retained_intron|processed_transcript     gene|lnc_RNA|lnc_RNA >
ILMN_1745398    PCDH15  ENST00000463095|ENSG00000150275 processed_transcript|protein_coding     lnc_RNA|gene    PCDH15-218|PCDH15
ILMN_2072091    HNRNPUL2        ENSG00000234857|ENSG00000214753 protein_coding|protein_coding   gene|gene       HNRNPUL2-BSCL2|HNRNPUL2
ILMN_1737738    NDUFA12 ENSG00000184752 protein_coding  gene    NDUFA12
ILMN_1668194    LMTK3   ENSG00000142235 protein_coding  gene    LMTK3
ILMN_1734542    OVGP1   ENSG00000085465 protein_coding  gene    OVGP1
ILMN_1672623    LRRC77P ENST00000481578|ENST00000459923 processed_transcript|processed_transcript       lnc_RNA|lnc_RNA LRRC77P-206|LRRC77P-201
ILMN_1666200    SHLD2   ENSG00000122376 protein_coding  gene    SHLD2
```

# Use the Docker image for reannotator pipeline

## Docker installation

Access the website https://www.docker.com/get-started for install docker program in Windows, MacOS or Linux systems.

## Download the reannotator image from Docker hub. Access the terminal and execute the command line
```
$ docker pull csblusp/reannotator
```

## For Linux and MacOS

### Create a Docker container for reannotator image
```
$ docker run -d -it --rm --name reannotator [-v <put your directory path here!>:/home] csblusp/reannotator
```
-v correspond to volumes parameter to link local directory to container directory and access/download files from the Docker container. Check out more details at the Docker volumes website: https://docs.docker.com/storage/volumes/

### Entry on the Docker container of reannotator
```
$ docker exec -it reannotator bash
```

### Entry on the reannotator pipeline directory
```
$ cd /home/reannotator_microarray_probes
$ git pull

$ cd /home/reannotator_microarray_probes/src
$ conda activate reannotator
```

Execute same steps from the [Prepare human genome sequence and mapper index](#prepare-human-genome-sequence-and-mapper-index)


## For Windows system
Under construction
