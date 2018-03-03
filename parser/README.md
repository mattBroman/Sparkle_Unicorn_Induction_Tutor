# Parser

The parser is implemented using `Node`, `PEGJS`, and `AVA`

## Setup

* run `npm i`

## Defining the Grammar

* Edit the `grammar.pegjs` file and define the grammar.
* run `npm run build` to transpile your changes

## Testing

* Define tests per token in the `tests` directory referencing `parser.js`
  * i.e. `expression.js`
* run `npm run test` to verify

## Using in the Ruby Project

* copy the transpiled `parser.js` to the Ruby Project
