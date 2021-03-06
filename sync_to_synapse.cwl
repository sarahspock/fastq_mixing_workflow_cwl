#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool


hints:
  DockerRequirement:
    dockerPull: quay.io/andrewelamb/synapse_python_client
    
baseCommand: [ python, /usr/local/bin/sync_to_synapse.py ]

arguments: [
  "--path",
  $(inputs.tsv_file.path),
  "--used",
  $(inputs.fastq_p1_synapse_ids),
  $(inputs.fastq_p2_synapse_ids),
  $(inputs.kallisto_index_synapse_id),
  "--executed",
  "https://github.com/Sage-Bionetworks/fastq_mixing_workflow_cwl",
  "https://github.com/Sage-Bionetworks/fastq_mixer",
  "https://github.com/Sage-Bionetworks/kallisto_cwl",
  "https://github.com/Sage-Bionetworks/synapse_python_client_cwl",
  "https://github.com/Sage-Bionetworks/misc_cwl"
  ]


inputs:

  synapse_config_file:
    type: File
    inputBinding:
      prefix: "--synapse_config_file"

  tsv_file:
    type: File

  upload_id:
    type: string
    inputBinding:
      prefix: "--parent"
  
  fastq_p1_synapse_ids: 
    type:
      type: array
      items: string

  fastq_p2_synapse_ids: 
    type:
      type: array
      items: string

  kallisto_index_synapse_id: 
    type: string

  activity_name:
    type: string
    default: "create_and_upload"
    inputBinding:
      prefix: "--activity_name"

  activity_description:
    type: string
    default: "mix fastqs, and do kallisto quantification"
    inputBinding:
      prefix: "--activity_description"

  yaml_config_file:
    type: ["null", File]
    inputBinding:
      prefix: "--yaml_config_file"

outputs:

  output:
    type: File
    outputBinding:
      glob: manifest.tsv