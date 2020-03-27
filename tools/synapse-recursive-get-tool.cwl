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
    type: File[]
    outputBinding:
      glob: 'fasta/*'
  - id: genes
    type: File
    outputBinding:
      glob: 'genes/genes.gtf'
  - id: pickle
    type: File
    outputBinding:
      glob: 'pickle/genes.pickle'
  - id: star
    type: File[]
    outputBinding:
      glob: 'star/*'
