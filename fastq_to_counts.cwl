class: Workflow
cwlVersion: v1.0
id: fastq_to_counts
label: fastq_to_counts
$namespaces:
  sbg: 'https://www.sevenbridges.com'
inputs:
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
    'sbg:x': -1047.2620849609375
    'sbg:y': -260
  - id: analysis_flag
    type: boolean
outputs:
  - id: combined_output
    outputSource:
      - wf_cellranger/combined_output
    type: File
    'sbg:x': -67
    'sbg:y': -421
steps:
  - id: download_genome
    in:
      - id: synapse_config
        source: synapse_config
      - id: synapseid
        source: genome_synapseid
    out:
      - id: output_dir
    run: tools/synapse-recursive-get-tool.cwl
    label: download genome
    'sbg:x': -734.206298828125
    'sbg:y': -536.5
  - id: sample_breakdown
    in:
      - id: synapse_config
        source: synapse_config
      - id: fastq_synapseid
        source: fastq_synapseid
    out:
      - id: sample_csvs
      - id: molecule_csv
    run: tools/sample_breakdown.cwl
    label: sample_breakdown.cwl
    'sbg:x': -828.60009765625
    'sbg:y': -278.2773742675781
  - id: download_fastq
    in:
      - id: synapse_config
        source: synapse_config
      - id: sample_csv
        source: sample_breakdown/sample_csvs
    out:
      - id: fastq
    run: tools/download_fastq.cwl
    label: download_fastq.cwl
    scatter:
      - sample_csv
    'sbg:x': -615.9705200195312
    'sbg:y': -342.6625671386719
  - id: wf_cellranger
    in:
      - id: sample_csv
        source: sample_breakdown/molecule_csv
      - id: fastq_dir
        source: download_fastq/fastq
      - id: genome_dir
        source: download_genome/output_dir
      - id: analysis_flag
        source: analysis_flag
    out:
      - id: combined_output
    run: ./wf-cellranger.cwl
    label: wf-cellranger
    'sbg:x': -226
    'sbg:y': -408
requirements:
  - class: SubworkflowFeatureRequirement
  - class: ScatterFeatureRequirement
