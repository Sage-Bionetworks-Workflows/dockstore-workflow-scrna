class: CommandLineTool
cwlVersion: v1.0
id: cellranger_count
baseCommand: ['cellranger', 'count']
inputs:
  - id: fastq_dir
    type: File[]
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
  - id: chemistry
    type: string?
    default: threeprime
  - id: sample
    type: string
  - id: analysis_flag
    type: boolean
    inputBinding:
      position: 6
      prefix: --nosecondary
outputs:
  - id: output
    type: File
    outputBinding:
      glob: '*molecule_info.h5'
      outputEval: |
        ${
          self[0].basename = inputs.sample + '_molecule_info.h5';
          return self[0]
        }
label: cellr_count
arguments:
  - position: 1
    prefix: '--id='
    separate: false
    valueFrom: $(inputs.sample)_run
  - position: 2
    prefix: '--fastqs='
    separate: false
    valueFrom: '.'
  - position: 3
    prefix: '--transcriptome='
    separate: false
    valueFrom: '.'
  - position: 4
    prefix: '--chemistry='
    separate: false
    valueFrom: $(inputs.chemistry)
  - position: 5
    prefix: '--sample='
    separate: false
    valueFrom: $(inputs.sample)
requirements:
  - class: DockerRequirement
    dockerPull: sagebionetworks/cellranger
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
  - class: InitialWorkDirRequirement
    listing:
    - entry: $(inputs.fastq_dir)
      entryname: $(inputs.sample)
#      writable: true
#    - entry: $(inputs.fastq_dir)
#    - entry: $(inputs.fasta)
#      entryname: 'fasta'
#    - entry: $(inputs.genes)
#      entryname: 'genes'
#    - entry: $(inputs.pickle)
#      entryname: 'pickle'
#    - entry: $(inputs.star)
#      entryname: 'star'
