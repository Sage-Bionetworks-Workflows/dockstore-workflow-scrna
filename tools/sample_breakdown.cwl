class: CommandLineTool
cwlVersion: v1.0
id: sample_breakdown
inputs:
  - id: synapse_config
    type: File
    inputBinding:
      position: 1
  - id: fastq_synapseid
    type: string
    inputBinding:
      position: 2
outputs:
  - id: sample_csvs
    type: File[]
    outputBinding:
      glob: '*samples.csv'
  - id: molecule_csv
    type: File
    outputBinding:
      glob: '*input.csv'
label: sample_breakdown.cwl
arguments: ['python3', 'breakdown.py']
hints:
  - class: DockerRequirement
    dockerPull: sagebionetworks/synapsepythonclient:v1.9.2
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: breakdown.py
        entry: |-
          #!/usr/bin/env python

          import synapseclient as sc
          import sys

          # Path to synapse config file
          synconf = sys.argv[1]
          # The synapseid containing the fastq files (assumes flat folder structure)
          synapseid = sys.argv[2]

          # Login to synapse
          syn = sc.Synapse(configPath=synconf)
          syn.login()

          def get_synids(parent):
              """Return a list of all synapseids corresponding to fastq files in a given folder"""
              entlist = []
              results = list(syn.getChildren(parent=parent, includeTypes=['file']))
              # For each entity in the folder, find all the fastq files
              for item in results:
                  entity = item['id']
                  if 'fastq' or '.fq' in entity:
                      entlist.append(entity)
              return entlist

          def get_annotations(entlist):
              """Take a list of synapseids and return a dictionary where {specimenid:[synapseids]}"""
              sampledict = {}
              for item in entlist:
                  specimen = syn.getAnnotations(item)['specimenID'][0]
                  if specimen not in sampledict:
                      sampledict[specimen] = [item]
                  else:
                      sampledict[specimen].append(item)
              return sampledict

          def write_csvs(sampledict):
              """For each specimen, write a csv file containing all of the synapseids for that specimen"""
              for specimen in sampledict:
                  for i in range(len(sampledict[specimen])):
                      print(str(specimen + ',' + sampledict[specimen][i]),file=open(str(specimen + '_' + 'samples.csv'), 'a'))

          def write_h5(sampledict):
              """Write the molecule_h5 file required by cellranger aggr"""
              print('library_id,molecule_h5', file=open('molecule_input.csv', 'w'))
              specimen = []
              for specimenid in sampledict:
                  if specimenid not in specimen:
                      specimen.append(specimenid)
                      print(str(specimenid + ',' + specimenid + '_molecule_info.h5'),file=open('molecule_input.csv','a'))

          def main(synapseid):
              synids = get_synids(synapseid)
              sampledict = get_annotations(synids)

              write_csvs(sampledict)
              write_h5(sampledict)

          main(synapseid)


