# `md-validator-rails-poc`

A proof-of-concept interactive web front end to the
[`md-validator`](https://github.com/iay/md-validator)
metadata validator web service project.

The container built is based on the `ruby:2.7-alpine` image.

A corresponding non-containerised development environment should include:

* Ruby 2.7
* Node.js 14
* Yarn 1.22

In my case:

```bash
$ ruby -v
ruby 2.7.4p191 (2021-07-07 revision a21a3b7d23) [x86_64-darwin20]
$ node -v
v14.18.1
$ yarn -v
1.22.17
```

I get these dependencies from [MacPorts](https://www.macports.org).

## Test Deployment

The `docker-test` script can be used to run a test container locally. The
application is exposed at `http://localhost:3000/md-validator-rails-poc`.
