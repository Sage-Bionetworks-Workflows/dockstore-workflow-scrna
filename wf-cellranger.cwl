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
  - id: fasta
    type: File[]
  - id: pickle
    type: File
  - id: star
    type: File[]
  - id: genes
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
      - id: fasta
        source: fasta
      - id: genes
        source: genes
      - id: pickle
        source: pickle
      - id: star
        source: star
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
  - class: MultipleInputFeatureRequirement
