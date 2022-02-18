# `md-validator-rails-poc`

A proof-of-concept interactive web front end to the
[`md-validator`](https://github.com/iay/md-validator)
metadata validator web service project.

The container built is based on the `ruby:3.0-alpine` image.

A corresponding non-containerised development environment should include:

* Ruby 3.0
* Node.js 14
* Yarn 1.22

In my case:

```bash
$ ruby -v
ruby 3.0.3p157 (2021-11-24 revision 3fb7d2cadc) [x86_64-darwin21]
$ node -v
v14.19.0
$ yarn -v
1.22.17
```

I get these dependencies from [MacPorts](https://www.macports.org).

## Test Deployment

The `docker-test` script can be used to run a test container locally. The
application is exposed at `http://localhost:3000/md-validator-rails-poc`.
