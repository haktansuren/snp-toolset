# SNP Toolset
Various scripts for SNP table convertion, modification and processing etc...

***SNP_HapMapToNumeric.pl*** - To convert your HapMap-type of SNP tables into numeric version. This is usefull for doing GWAS study if input is required to be numeric.

**Usage:**
```sh
perl SNP_HapMapToNumeric.pl snp-file start-column  
```

**Example:**
```sh
perl SNP_HapMapToNumeric.pl snp-table.hmp.txt 12  
```

**Description:**
Program takes two argument, first argument is the HapMap file and second is the starting column number for the data (assuming first few columns are informative columns). If your data does not have any informative columns prior to SNP columns, enter 0 (zero). If it is HapMap data, you would like to use 12. 
