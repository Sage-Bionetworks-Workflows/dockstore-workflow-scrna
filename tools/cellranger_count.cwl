class: CommandLineTool
cwlVersion: v1.0
id: cellranger_count
baseCommand: ['cellranger', 'count']
inputs:
  - id: fastq_dir
    type: File[]
  - id: fasta
    type: File
  - id: fai
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
  - id: pickle
    type: File
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
      writable: true
    - entry: $(inputs.fasta)
      entryname: 'fasta/$(inputs.fasta.basename)'
      writable: true
    - entry: $(inputs.fai)
      entryname: 'fasta/$(inputs.fai.basename)'
      writable: true
    - entry: $(inputs.Genome)
      entryname: 'star/$(inputs.Genome)'
      writable: true
    - entry: $(inputs.SA)
      entryname: 'star/$(inputs.SA.basename)'
      writable: true
    - entry: $(inputs.SAindex)
      entryname: 'star/$(inputs.SAindex.basename)'
      writable: true
    - entry: $(inputs.chrLength)
      entryname: 'star/$(inputs.chrLength.basename)'
      writable: true
    - entry: $(inputs.chrName)
      entryname: 'star/$(inputs.chrName.basename)'
      writable: true
    - entry: $(inputs.chrNameLength)
      entryname: 'star/$(inputs.chrNameLength.basename)'
      writable: true
    - entry: $(inputs.chrStart)
      entryname: 'star/$(inputs.chrStart.basename)'
      writable: true
    - entry: $(inputs.exonGeTrInfo)
      entryname: 'star/$(inputs.exonGeTrInfo.basename)'
      writable: true
    - entry: $(inputs.exonInfo)
      entryname: 'star/$(inputs.exonInfo.basename)'
      writable: true
    - entry: $(inputs.geneInfo)
      entryname: 'star/$(inputs.geneInfo.basename)'
      writable: true
    - entry: $(inputs.genomeParameters)
      entryname: 'star/$(inputs.genomeParameters.basename)'
      writable: true
    - entry: $(inputs.sjdbInfo)
      entryname: 'star/$(inputs.sjdbInfo.basename)'
      writable: true
    - entry: $(inputs.sjdbList)
      entryname: 'star/$(inputs.sjdbList.basename)'
      writable: true
    - entry: $(inputs.sjdbListout)
      entryname: 'star/$(inputs.sjdbListout.basename)'
      writable: true
    - entry: $(inputs.transcriptInfo)
      entryname: 'star/$(inputs.transcriptInfo.basename)'
      writable: true
    - entry: $(inputs.genes)
      entryname: 'genes/$(inputs.genes.basename)'
      writable: true
    - entry: $(inputs.pickle)
      entryname: 'pickle/$(inputs.pickle.basename)'
      writable: true
