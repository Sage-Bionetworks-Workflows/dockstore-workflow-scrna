class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com'
id: cellranger count
baseCommand: ['cellranger', 'count']
inputs:
  - id: fastq_dir
    type: Directory
  - id: genome_dir
    type: Directory
  - id: chemistry
    type: string?
    default: threeprime
  - id: sample_id
    type: string?
    default: test
outputs:
  - id: output
    type: File
    outputBinding:
      glob: '$(inputs.sample_id)/outs/molecule_info.h5'
label: cellr_count
arguments:
  - position: 1
    prefix: '--id='
    separate: false
    valueFrom: $(inputs.sample_id)
  - position: 2
    prefix: '--fastqs='
    separate: false
    valueFrom: $(inputs.fastq_dir)
  - position: 3
    prefix: '--transcriptome='
    separate: false
    valueFrom: $(inputs.genome_dir)
  - position: 4
    prefix: '--chemistry='
    separate: false
    valueFrom: $(inputs.chemistry)
requirements:
  - class: DockerRequirement
    dockerPull: sagebionetworks/cellranger:develop-latest
  - class: InlineJavascriptRequirement

