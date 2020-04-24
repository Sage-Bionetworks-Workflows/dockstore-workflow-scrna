class: Workflow
cwlVersion: v1.0
id: wf_cellranger
label: wf-cellranger
$namespaces:
  sbg: 'https://www.sevenbridges.com'
inputs:
  - id: fastq_dir
    type:
      type: array
      items:
        type: array
        items: File
  - id: reference
    type: File
  - id: fasta
    type: File
  - id: fai
    type: File
  - id: pickle
    type: File
  - id: genes
    type: File
  - id: Genome
    type: File
  - id: SA
    type: File
  - id: SAindex
    type: File
  - id: chrLength
    type: File
  - id: chrName
    type: File
  - id: chrNameLength
    type: File
  - id: chrStart
    type: File
  - id: exonGeTrInfo
    type: File
  - id: exonInfo
    type: File
  - id: geneInfo
    type: File
  - id: genomeParameters
    type: File
  - id: sjdbInfo
    type: File
  - id: sjdbList
    type: File
  - id: sjdbListout
    type: File
  - id: transcriptInfo
    type: File
  - id: sample_csv
    type: File
  - id: sample
    type: string[]
  - id: analysis_flag
    type: boolean
outputs:
  - id: combined_output
    outputSource:
      - cellranger_aggr/combined_output
    type: File
    'sbg:x': 151.793701171875
    'sbg:y': -193.5
steps:
  - id: cellranger_count
    in:
      - id: fastq_dir
        source: fastq_dir
      - id: reference
        source: reference
      - id: fasta
        source: fasta
      - id: fai
        source: fai
      - id: genes
        source: genes
      - id: pickle
        source: pickle
      - id: Genome
        source: Genome
      - id: SA
        source: SA
      - id: SAindex
        source: SAindex
      - id: chrLength
        source: chrLength
      - id: chrName
        source: chrName
      - id: chrNameLength
        source: chrNameLength
      - id: chrStart
        source: chrStart
      - id: exonGeTrInfo
        source: exonGeTrInfo
      - id: exonInfo
        source: exonInfo
      - id: geneInfo
        source: geneInfo
      - id: genomeParameters
        source: genomeParameters
      - id: sjdbInfo
        source: sjdbInfo
      - id: sjdbList
        source: sjdbList
      - id: sjdbListout
        source: sjdbListout
      - id: transcriptInfo
        source: transcriptInfo
      - id: sample
        source: sample
      - id: sample_csv
        source: sample_csv
      - id: analysis_flag
        source: analysis_flag
    out:
      - id: output
    scatter: [fastq_dir, sample]
    scatterMethod: dotproduct
    run: tools/cellranger_count.cwl
    label: cellr_count
    'sbg:x': -591.203125
    'sbg:y': -231.5
  - id: cellranger_aggr
    in:
      - id: molecule_h5
        source:
          - cellranger_count/output
      - id: sample_csv
        source: sample_csv
      - id: analysis_flag
        source: analysis_flag
    out:
      - id: combined_output
    run: tools/cellranger_aggr.cwl
    label: cellranger aggr
    'sbg:x': 11.793701171875
    'sbg:y': -207.5
requirements:
  - class: MultipleInputFeatureRequirement
  - class: ScatterFeatureRequirement
