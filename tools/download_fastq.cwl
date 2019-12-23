class: CommandLineTool
cwlVersion: v1.0
id: download_fastq
inputs:
  - id: synapse_config
    type: File
    inputBinding:
      position: 1
  - id: sample_csv
    type: File
    inputBinding:
      position: 2
outputs:
  - id: fastq
    type: Directory
    outputBinding:
      glob: '*'
      outputEval: |
        ${
          self[0].nameroot = inputs.sample_csv.nameroot.split('_',1);
          return self[0]
        }
label: download_fastq.cwl
arguments: ['python3', 'download_fastq.py']
hints:
  - class: DockerRequirement
    dockerPull: sagebionetworks/synapsepythonclient:v1.9.2
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: download_fastq.py
        entry: |-
          #!/usr/bin/env python

          import synapseclient as sc
          import sys

          # Path to synapse config file
          synconf = sys.argv[1]
          # The csv file containing specimenid-synapseid mappings
          sample_csv = sys.argv[2]

          # Login to synapse
          syn = sc.Synapse(configPath=synconf)
          syn.login()

          for line in open(sample_csv):
              line = line.strip()
              specimen, synid = line.split(',')
              entity = syn.get(synid, downloadLocation=specimen)
              print(entity.name)
              print(entity.path)
  - class: ResourceRequirement
    ramMin: 6000
    coresMin: 1
    tmpdirMin: 225000
    outdirMin: 225000

