class: Workflow
cwlVersion: v1.0
id: wf_cellranger
label: wf-cellranger
$namespaces:
  sbg: 'https://www.sevenbridges.com'
inputs:
  - id: sample_csv
    type: File
    'sbg:x': -193.206298828125
    'sbg:y': -361.5
  - id: fastq_dir
    type: Directory[]
    'sbg:x': -697.206298828125
    'sbg:y': -173.5
  - id: genome_dir
    type: Directory
    'sbg:x': -705.206298828125
    'sbg:y': -299.5
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
      - id: genome_dir
        source: genome_dir
    out:
      - id: output
    scatter: fastq_dir
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
    out:
      - id: combined_output
    run: tools/cellranger_aggr.cwl
    label: cellranger aggr
    'sbg:x': 11.793701171875
    'sbg:y': -207.5
requirements: []
