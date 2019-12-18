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
    type: File[]
    outputBinding:
      glob: '*fastq*'
label: download_fastq.cwl
arguments: ['python3', 'breakdown.py']
hints:
  - class: DockerRequirement
    dockerPull: sagebionetworks/synapsepythonclient:v1.9.2
requirements:
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
              entity = syn.get(synid, downloadLocation='.')
              print(entity.name)
              print(entity.path)

