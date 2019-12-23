# SCRNA-CWL Workflow
This workflow processes single cell RNA sequencing data from the 10X Genomics Platform.  None of the tools or files in this repository are provided or supported by 10X Genomics. SCRNA-CWL performs the following tasks:

- Creates a csv report of basic input data provenance (synapseid, file version numbers)
- Groups input fastq files based on the specimen ID provided in the [Synapse](https://www.synapse.org/) annotation
- Downloads input fastq files using the [Synapse Python Client](https://python-docs.synapse.org/build/html/index.html)
- Performs molecule counting using the [cellranger count](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/tutorial_ct) function
- Aggregates gene counts across specimen using the [cellranger aggr](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/aggregate) function
- Uploads results to a specified [Synapse](https://www.synapse.org/) with appropriate provenance

## Workflow Dependencies
To execute this workflow, input fastq files must be present in a [Synapse](https://www.synapse.org/) folder and each file must contain an annotation for the *specimenId* field. In addition, the following dependencies must be installed:

- [Docker](https://www.docker.com/)
- A workflow execution engine that is compatible with [CWL](https://www.commonwl.org/).  Examples include [cwl-tool](https://github.com/common-workflow-language/cwltool) and [Toil](https://toil.readthedocs.io/en/latest/)

### Execution with cwltool

To execute a test workflow that contains non-phi data from the [SRA](https://www.ncbi.nlm.nih.gov/sra) archive, execute the following command:

```bash
cwl-runner fastq_to_counts.cwl jobs/test_SRA/job.json
```

### Execution with toil

To execute a test workflow that contains non-phi data from the [SRA](https://www.ncbi.nlm.nih.gov/sra) archive, create a [toil cluster](https://toil.readthedocs.io/en/3.15.0/running/cloud/clusterUtils.html) and execute the following command:

```bash
./run-toil.py jobs/test_SRA
```
