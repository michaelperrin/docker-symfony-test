Symfony Docker quick test
=========================

A quick test to show how Symfony is slow using Docker / Docker beta (yup, the one that
leverages OS X virtualization technology) on OS X.

This is due to the volume share. Using Symfony in a container without sharing volume is very fast (~20ms in dev mode).

## Install

    docker build -t sf-test .
    docker run -d -p 8080:8080 -v `pwd`:/var/www/symfony_project --name symfony_docker_test sf-test

Make sure that Composer is done running and that the server is started:

    docker logs -f symfony_docker_test

## Have a look at Symfony's default homepage

Open in your browser the following URL: [http://localhost:8080](http://localhost:8080).


## Results

The example is much faster on the `master` branch since I moved the `cache`, `logs` and `vendor` (biggest win with this one) directories outside of the shared directory.
You can switch to the `non-shared-vendor` branch to make tests with `cache`, `logs` and `vendor` dirs in the shared volume (which is the default Symfony install).

Benchmarks results from this command in Symfony `prod` environment:

    ab -n 100 -r 127.0.0.1:8080
    OR
    ab -n 100 -r http://127.0.0.1:8080/

|                                                         | Docker 1.11.1-beta11 | Docker 1.11.1-beta13 |
|---------------------------------------------------------|----------------------|----------------------|
| Shared (the default) – *shared-vendor-and-cache branch* | 210 seconds          | *26.9 seconds*       |
| Not shared: cache, logs and vendors – *master branch*   | 11.9 seconds         | *5.6 seconds*        |
| Not shared: vendors – *non-shared-vendor branch*        | 10.9 seconds         | *not tested yet*     |
