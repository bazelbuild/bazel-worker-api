#/bin/sh
#
# Usage: if you're releasing version 1.2.3, run:
#   ./release.sh 1.2.3
#
# This creates a release archive named bazel-worker-api-v1.2.3.tar.gz.
# Now create a release using GitHub's UI, with tag `v1.2.3` and release name `1.2.3`. Upload this archive as an attachment. Profit!

VER=$1
git archive --format=tar --prefix=bazel-worker-api-${VER}/ `git rev-parse HEAD` java proto | gzip > bazel-worker-api-v${VER}.tar.gz
