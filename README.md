# GitHub Action: Prevent Big Files

This GitHub action checks that your git objects are not too large.

This can be used to help prevent repository bloat by people commiting binaries including executables, images and videos.

## Usage

Note that you'll need to fetch all commits between your target branch and your pull request head.
This can be most easily via the `fetch-depth: 0` option to the `actions/checkout` action.

Example workflow:

```yaml
name: Pull Request

on:
  pull_request:
    branches: [ '**' ]

jobs:
  prevent_big_files:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      - uses: james-callahan/gha-prevent-big-files@main
        with:
          max-size: 4096
```
