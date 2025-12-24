## Deprecation

This repository is now archived (since 2025-12-24).

# Scalingo Cairo Buildpack

This is a buildpack that installs [Cairo](http://cairographics.org/) and
its dependencies ([Pango](http://www.pango.org/), [Pixman](http://pixman.org/),
[FreeType](http://www.freetype.org/),
[HarfBuzz](http://www.freedesktop.org/wiki/Software/HarfBuzz/), and
[giflib](http://giflib.sourceforge.net/)) into a container image.

When used with
[multi-buildpack](https://github.com/Scalingo/multi-buildpack),
it enables subsequent buildpacks / steps to any of these libraries.

## Using this buildpack

You'll almost certainly want to use this in conjunction with one or more
additional buildpacks.

If you haven't created your scalingo application:

```bash
scalingo create <appname>
```
Then you need to configure your app to use the cairo-buildpack. In the following
example, we're using the cairo-buildpack and the nodejs buildpack to deploy a node
or a Meteor app, it may change if you're using a different technology.

```bash
scalingo env-set BUILDPACK_URL=https://github.com/Scalingo/multi-buildpack.git

cat << EOF > .buildpacks
https://github.com/Scalingo/cairo-buildpack.git
https://github.com/Scalingo/nodejs-buildpack.git
EOF

git add .buildpacks
git commit -m "Add multi buidpack configuration"
git push scalingo master
```

## Stack compatibility

This buildpack is available for two stacks:
- ubuntu-18 that is the current up-to-date one. Libs are installed from the packages.
- ubuntu-14, with a legacy mode. Libs were compiled and installed via a S3 download.
