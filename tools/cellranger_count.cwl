class: CommandLineTool
cwlVersion: v1.0
id: cellranger_count
baseCommand: ['cellranger', 'count']
inputs:
  - id: fastq_dir
    type: File[]
  - id: reference
    type: File
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
      glob: '$(inputs.sample)_run/outs/molecule_info.h5'
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
    valueFrom: 'reference'
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
    - entry: $(inputs.reference)
      entryname: 'reference/$(inputs.reference.basename)'
      writable: true
    - entry: $(inputs.fasta)
      entryname: 'reference/fasta/$(inputs.fasta.basename)'
      writable: true
    - entry: $(inputs.fai)
      entryname: 'reference/fasta/$(inputs.fai.basename)'
      writable: true
    - entry: $(inputs.Genome)
      entryname: 'reference/star/$(inputs.Genome.basename)'
      writable: true
    - entry: $(inputs.SA)
      entryname: 'reference/star/$(inputs.SA.basename)'
      writable: true
    - entry: $(inputs.SAindex)
      entryname: 'reference/star/$(inputs.SAindex.basename)'
      writable: true
    - entry: $(inputs.chrLength)
      entryname: 'reference/star/$(inputs.chrLength.basename)'
      writable: true
    - entry: $(inputs.chrName)
      entryname: 'reference/star/$(inputs.chrName.basename)'
      writable: true
    - entry: $(inputs.chrNameLength)
      entryname: 'reference/star/$(inputs.chrNameLength.basename)'
      writable: true
    - entry: $(inputs.chrStart)
      entryname: 'reference/star/$(inputs.chrStart.basename)'
      writable: true
    - entry: $(inputs.exonGeTrInfo)
      entryname: 'reference/star/$(inputs.exonGeTrInfo.basename)'
      writable: true
    - entry: $(inputs.exonInfo)
      entryname: 'reference/star/$(inputs.exonInfo.basename)'
      writable: true
    - entry: $(inputs.geneInfo)
      entryname: 'reference/star/$(inputs.geneInfo.basename)'
      writable: true
    - entry: $(inputs.genomeParameters)
      entryname: 'reference/star/$(inputs.genomeParameters.basename)'
      writable: true
    - entry: $(inputs.sjdbInfo)
      entryname: 'reference/star/$(inputs.sjdbInfo.basename)'
      writable: true
    - entry: $(inputs.sjdbList)
      entryname: 'reference/star/$(inputs.sjdbList.basename)'
      writable: true
    - entry: $(inputs.sjdbListout)
      entryname: 'reference/star/$(inputs.sjdbListout.basename)'
      writable: true
    - entry: $(inputs.transcriptInfo)
      entryname: 'reference/star/$(inputs.transcriptInfo.basename)'
      writable: true
    - entry: $(inputs.genes)
      entryname: 'reference/genes/$(inputs.genes.basename)'
      writable: true
    - entry: $(inputs.pickle)
      entryname: 'reference/pickle/$(inputs.pickle.basename)'
      writable: true
