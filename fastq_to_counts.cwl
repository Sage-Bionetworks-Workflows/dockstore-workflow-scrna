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
      - id: reference
      - id: fasta
      - id: fai
      - id: genes
      - id: pickle
      - id: Genome
      - id: SA
      - id: SAindex
      - id: chrLength
      - id: chrName
      - id: chrNameLength
      - id: chrStart
      - id: exonGeTrInfo
      - id: exonInfo
      - id: geneInfo
      - id: genomeParameters
      - id: sjdbInfo
      - id: sjdbList
      - id: sjdbListout
      - id: transcriptInfo
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
      - id: fastq_dir
    run: tools/download_fastq.cwl
    label: download_fastq.cwl
    scatter:
      - sample_csv
    'sbg:x': -615.9705200195312
    'sbg:y': -342.6625671386719
  - id: grab_sample
    in:
      - id: sample_csv
        source: sample_breakdown/sample_csvs
    out:
      - id: sample
    run: tools/grab_sample.cwl
    label: grab_sample.cwl
    scatter:
      - sample_csv
  - id: wf_cellranger
    in:
      - id: sample_csv
        source: sample_breakdown/molecule_csv
      - id: fastq_dir
        source: download_fastq/fastq_dir
      - id: reference
        source: download_genome/reference
      - id: fasta
        source: download_genome/fasta
      - id: fai
        source: download_genome/fai
      - id: genes
        source: download_genome/genes
      - id: pickle
        source: download_genome/pickle
      - id: Genome
        source: download_genome/Genome
      - id: SA
        source: download_genome/SA
      - id: SAindex
        source: download_genome/SAindex
      - id: chrLength
        source: download_genome/chrLength
      - id: chrName
        source: download_genome/chrName
      - id: chrNameLength
        source: download_genome/chrNameLength
      - id: chrStart
        source: download_genome/chrStart
      - id: exonGeTrInfo
        source: download_genome/exonGeTrInfo
      - id: exonInfo
        source: download_genome/exonInfo
      - id: geneInfo
        source: download_genome/geneInfo
      - id: genomeParameters
        source: download_genome/genomeParameters
      - id: sjdbInfo
        source: download_genome/sjdbInfo
      - id: sjdbList
        source: download_genome/sjdbList
      - id: sjdbListout
        source: download_genome/sjdbListout
      - id: transcriptInfo
        source: download_genome/transcriptInfo
      - id: sample
        source: grab_sample/sample
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
