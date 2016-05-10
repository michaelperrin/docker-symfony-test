Symfony Docker quick test
=========================

A quick test to show how Symfony is slow using Docker / Docker beta (yup, the one that
leverages OS X virtualization technology) on OS X.

This is due to the volume share. Using Symfony in a container without sharing volume is very fast (~20ms in dev mode).

*Edit:* The example is now much faster since the `cache`, `logs` and `vendor` (biggest win with this one)
directories have been moved outside the shared directory.

## Install

    docker build -t sf-test .
    docker run -d -p 8080:8080 -v `pwd`:/var/www/symfony_project --name symfony_docker_test sf-test

Make sure that Composer is done running and that the server is started:

    docker logs -f symfony_docker_test

## Have a look at Symfony's default homepage

Open in your browser the following URL: [http://localhost:8080](http://localhost:8080).
