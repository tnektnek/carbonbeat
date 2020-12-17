# Contributing to Carbonbeat

## Setting up the dev environment

Ensure that this folder is at the following location:
`${GOPATH}/github.com/tnektnek/carbonbeat`

### Requirements

* [Golang](https://golang.org/dl/) 1.7+
* [dep](https://github.com/golang/dep) package manager

For further information on beats framework, check out the [beat developer guide](https://www.elastic.co/guide/en/beats/libbeat/current/new-beat.html).

### Build

To build the binary for Carbonbeat run the command below. This will generate a binary
in the same directory with the name carbonbeat.

```
make
```


### Run

To run Carbonbeat with debugging output enabled, run:

```
./carbonbeat -c carbonbeat.yml -e -d "*"
```


To clean up the build directory and generated artifacts, run:

```
make clean
```


### Clone

To clone Carbonbeat from the git repository, run the following commands:

```
mkdir -p ${GOPATH}/github.com/tnektnek/carbonbeat
cd ${GOPATH}/github.com/tnektnek/carbonbeat
git clone https://github.com/tnektnek/carbonbeat
```

## Packaging

The beat frameworks provides tools to crosscompile and package your beat for different platforms. This requires [docker](https://www.docker.com/) and vendoring as described above. To build packages of your beat, run the following command:

```
make package
```

This will fetch and create all images required for the build process. The whole process to finish can take several minutes.
