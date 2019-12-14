class: Workflow
cwlVersion: v1.0
id: fastq_to_counts
label: fastq_to_counts
$namespaces:
  sbg: 'https://www.sevenbridges.com'
inputs:
  - id: sample_csv
    type: File
    'sbg:x': -543.206298828125
    'sbg:y': -677.5
  - id: synapse_config
    type: File
    'sbg:x': -1054
    'sbg:y': -488
  - id: genome_synapseid
    type: string
    'sbg:x': -955
    'sbg:y': -684
  - id: fastq_synapseid
    type: string
    'sbg:x': -1050
    'sbg:y': -254
outputs:
  - id: output
    outputSource:
      - cellranger_aggr/output
    type: Directory
    'sbg:x': 410.793701171875
    'sbg:y': -391.5
steps:
  - id: synapse_recursive_get
    in:
      - id: synapse_config
        source: synapse_config
      - id: synapseid
        default: $(inputs.genome_synapseid)
        source: genome_synapseid
    out:
      - id: output_dir
    run: tools/synapse-recursive-get-tool.cwl
    label: Recursive synapse get
    'sbg:x': -734.206298828125
    'sbg:y': -536.5
  - id: cellranger_count
    in:
      - id: fastq_dir
        source: synapse_recursive_get_1/output_dir
      - id: genome_dir
        source: synapse_recursive_get/output_dir
    out:
      - id: output
    run: tools/cellranger_count.cwl
    label: cellr_count
    'sbg:x': -376.206298828125
    'sbg:y': -398.5
  - id: cellranger_aggr
    in:
      - id: molecule_h5
        source: cellranger_count/output
      - id: sample_csv
        source: sample_csv
    out:
      - id: output
    run: tools/cellranger_aggr.cwl
    label: cellr_aggr
    'sbg:x': 166.793701171875
    'sbg:y': -377.5
  - id: synapse_recursive_get_1
    in:
      - id: synapse_config
        source: synapse_config
      - id: synapseid
        source: fastq_synapseid
    out:
      - id: output_dir
    run: tools/synapse-recursive-get-tool.cwl
    label: Recursive synapse get
    'sbg:x': -723.206298828125
    'sbg:y': -347.5
requirements: []
