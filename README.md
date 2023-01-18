# `md-validator-rails-poc`

A proof-of-concept interactive web front end to the
[`md-validator`](https://github.com/iay/md-validator)
metadata validator web service project.

The container built is based on the `ruby:3.0-alpine` image.

A corresponding non-containerised development environment should include:

* Ruby 3.2
* Node.js 14
* Yarn 1.22

In my case:

```bash
$ ruby -v
ruby 3.2.0 (2022-12-25 revision a528908271) [x86_64-darwin22]
$ node -v
v14.21.2
$ yarn -v
1.22.19
```

I get these dependencies from [MacPorts](https://www.macports.org).

## Test Deployment

The `docker-test` script can be used to run a test container locally. The
application is exposed at `http://localhost:3000/md-validator-rails-poc`.
