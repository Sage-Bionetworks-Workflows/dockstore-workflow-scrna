class: CommandLineTool
cwlVersion: v1.0
id: download_fastq
stdout: cwl.output.json
inputs:
  - id: sample_csv
    type: File
    inputBinding:
      position: 1
outputs:
  - id: sample
    type: string
label: grab_sample.cwl
arguments: ['python3', 'grab_sample.py']
hints:
  - class: DockerRequirement
    dockerPull: sagebionetworks/synapsepythonclient:v1.9.2
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: grab_sample.py
        entry: |-
          #!/usr/bin/env python

          import sys

          # The csv file containing specimenid-synapseid mappings
          sample_csv = sys.argv[1]

          for line in open(sample_csv):
              specimen, synid = line.split(',')
              print(str('{"sample":' + '\"' +  specimen + '\"' + '}'), file=open('cwl.output.json','w'))
