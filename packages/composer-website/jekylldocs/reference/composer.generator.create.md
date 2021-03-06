---
layout: default
title: Hyperledger Composer Generator CLI
section: reference-command
sidebar: sidebars/accordion-toc0.md
excerpt: Composer Generator Create CLI
---

## Name

composer generator create - create code artifacts based on a business network definition

## Synopsis

```
composer generator create <options>

Options:
  --help             Show help  [boolean]
  -v, --version      Show version number  [boolean]
  --archiveFile, -a  Business network archive file name. Default is based on the Identifier of the BusinessNetwork  [string] [required]
  --format, -f       Format of code to generate: Go (beta), PlantUML, Typescript (beta), JSONSchema.  [required]
  --outputDir, -o    Output Location  [required]

```

## Description

This will take the {{site.data.conrefs.composer_full}} business network definition as input and create artifacts related to writing new applications.

## Options

* `-a` `--archiveFile`  
The path to the business network archive file. This will be the source that is used to create the artifacts
* `-f` `--format`  
The format of the artifacts that will be created.
   * **go** Generates class definitions in the go language for the assets and participants
   * **Typescript** Generates class definitions in the Typescript language for the assets and participants
   * **JSONSchema** Generates the equivalent to the model in JSONSchema
   * **PlantUML** Generates a description of the model suitable for use with PlantUML to generate diagrams
   * **XmlSchema** Generates a set of XML Schema (XSD) files

* `--help`  
Shows the help text
* `-v` `--version`  
Shows the version number
* `-o, --outputDir`
The output directory for the generated files.

## Example Usage

```bash
composer generator create --archiveFile digitalPropertyNetwork.bna --format Go --outputDir ./dev/go-app
```

## Javascript API Example

```javascript
const GeneratorCreate = require('composer-cli').Generator.Create;

let options = {
  archiveFile: 'digitalPropertyNetwork.bna',
  format: 'Go',
  outputDir: './dev/go-app'
};

GeneratorCreate.handler(options);
```
