#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: synapse-recursive-get
label: Recursive synapse get
doc: Get all children of a particular synapse id

baseCommand: synapse

inputs:
  - id: synapse_config
    type: File
  - id: synapseid
    type: string

requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .synapseConfig
        entry: $(inputs.synapse_config)
  - class: DockerRequirement
    dockerPull: sagebionetworks/synapsepythonclient:v1.9.2
arguments: ["get", "-r", $(inputs.synapseid)]
outputs:
  - id: fasta
    type: File
    outputBinding:
      glob: 'fasta/genome.fa'
  - id: fai
    type: File
    outputBinding:
      glob: 'fasta/genome.fa.fai'
  - id: genes
    type: File
    outputBinding:
      glob: 'genes/genes.gtf'
  - id: pickle
    type: File
    outputBinding:
      glob: 'pickle/genes.pickle'
  - id: Genome
    type: File
    outputBinding:
      glob: 'star/Genome'
  - id: SA
    type: File
    outputBinding:
      glob: 'star/SA'
  - id: SAindex
    type: File
    outputBinding:
      glob: 'star/SAindex'
  - id: chrLength
    type: File
    outputBinding:
      glob: 'star/chrLength.txt'
  - id: chrName
    type: File
    outputBinding:
      glob: 'star/chrName.txt'
  - id: chrNameLength
    type: File
    outputBinding:
      glob: 'star/chrNameLength.txt'
  - id: chrStart
    type: File
    outputBinding:
      glob: 'star/chrStart.txt'
  - id: exonGeTrInfo
    type: File
    outputBinding:
      glob: 'star/exonGeTrInfo.tab'
  - id: exonInfo
    type: File
    outputBinding:
      glob: 'star/exonInfo.tab'
  - id: geneInfo
    type: File
    outputBinding:
      glob: 'star/geneInfo.tab'
  - id: genomeParameters
    type: File
    outputBinding:
      glob: 'star/genomeParameters.txt'
  - id: sjdbInfo
    type: File
    outputBinding:
      glob: 'star/sjdbInfo.txt'
  - id: sjdbList
    type: File
    outputBinding:
      glob: 'star/sjdbList.fromGTF.out.tab'
  - id: sjdbListout
    type: File
    outputBinding:
      glob: 'star/sjdbList.out.tab'
  - id: transcriptInfo
    type: File
    outputBinding:
      glob: 'star/transcriptInfo.tab'



