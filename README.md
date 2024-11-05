# Cell Ranger ATAC Docker Pipeline

This repository contains a Dockerized version of 10x Genomics Cell Ranger ATAC pipeline for processing single-cell ATAC-seq data.

## Quick Start

### 1. Build Docker Image

```bash
docker build -t cellranger-atac .
```

### 2. Prepare Data Directories
Create required directories for data organization:

```bash
mkdir -p ~/cellranger_data/{fastqs,reference,output}
```

### 3. Data Preparation
Place your FASTQ files in `~/cellranger_data/fastqs/`
Download reference data to `~/cellranger_data/reference/`
Output will be generated in `~/cellranger_data/output/`

### 4. Run Analysis

Non-interactive docker container run 
```bash
docker run -v ~/cellranger_data:/data cellranger-atac \
    cellranger-atac count \
    --id=run1 \
    --reference=/data/reference/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
    --fastqs=/data/fastqs \
    --sample=SAMPLE_NAME
```

Interactive docker container run
```bash
docker run -it -v ~/cellranger_data:/data cellranger-atac bash
```
This command: 
* -it enables interactive terminal
* -v mounts your local data directory
* bash starts an interactive bash shell

Once inside the container, you can: 
* Navigate directories: cd /data
* Check Cell Ranger ATAC version: cellranger-atac --version
* Run commands directly: 
```bash
cellranger-atac count \
    --id=run1 \
    --reference=/data/reference/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
    --fastqs=/data/fastqs \
    --sample=SAMPLE_NAME
```
* Explore outputs in real-time
* Test different parameters
* Exit container when done: exit

The interactive session gives flexibility in monitoring the analysis within the container environment. 





## Input Requirements
FASTQ Files 
* R1: Forward genomic reads
* R2: Cell barcode and sample index
* R3: Reverse genomic reads
Example naming convention:
```bash
SAMPLE_S1_L002_R1_001.fastq.gz
SAMPLE_S1_L002_R2_001.fastq.gz
SAMPLE_S1_L002_R3_001.fastq.gz
```

## Reference Genome
Download from 10x Genomics:

* Mouse genome (mm10)
```bash
wget https://cf.10xgenomics.com/supp/cell-atac/refdata-cellranger-arc-mm10-2020-A-2.0.0.tar.gz
```

* Human genome (GRCh38)
```bash
wget https://cf.10xgenomics.com/supp/cell-atac/refdata-cellranger-arc-GRCh38-2020-A-2.0.0.tar.gz
```

## Expected Outputs
The pipeline generates several key outputs in the `~/cellranger_data/output/run1/` directory:

1. `web_summary.html`: A summary report of the analysis results.
2. `cloupe.cloupe`: A file for visualization in Loupe Browser.
3. `filtered_peak_bc_matrix/`: Directory containing filtered peak-barcode matrices.
4. `filtered_tf_bc_matrix/`: Directory containing filtered transcription factor matrices.
5. `analysis/`: Directory with various analysis results (clustering, dimensionality reduction, etc.).
6. `possorted_bam.bam`: Aligned reads in BAM format.
7. `peaks.bed`: Called peaks in BED format.
8. `fragments.tsv.gz`: Fragment file for custom analyses.

## Key Metrics
* Number of cells detected
* Median fragments per cell
* TSS enrichment score
* Fraction of reads in peaks
* Fragment size distribution

## Analysis Results
* Dimension reduction plots (UMAP/tSNE)
* Clustering information
* Peak annotations
* Cell-type assignments (if reference is provided)

## Resource Requirements
Recommended specifications:

RAM: 32GB minimum
CPU: 8 cores minimum
Storage: 500GB minimum




## Troubleshooting
If you encounter issues:

1. Ensure Docker has sufficient resources allocated.
2. Verify input data integrity and format.
3. Check for sufficient disk space.
4. Review logs in the output directory for specific error messages.


## Additional Resources
- [Cell Ranger ATAC Documentation](https://support.10xgenomics.com/single-cell-atac/software/pipelines/latest/what-is-cell-ranger-atac)
- [10x Genomics Support](https://support.10xgenomics.com/)



## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For questions or support, please open an issue in this repository.
