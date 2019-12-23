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
  - class: ResourceRequirement
    ramMin: 6000
    coresMin: 1
    tmpdirMin: 225000
    outdirMin: 225000
arguments: ["get", "-r", $(inputs.synapseid)]
outputs:
  - id: output_dir
    type: Directory
    outputBinding:
      glob: '.'
