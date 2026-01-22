#/bin/sh

VER=$1
if ! [[ "$VER" =~ ^[0-9] ]]; then
  cat <<'EOF'
Usage: if you're releasing version 1.2.3, run:
  ./release.sh 1.2.3

This creates a release archive named bazel-worker-api-v1.2.3.tar.gz.
Now create a release using GitHub's UI, with tag `v1.2.3` and release name `1.2.3`. Upload this archive as an attachment. Profit!
Make sure your git tree is clean before using.
EOF
  exit 1
fi
sed -i '' 's/bazel_dep(name = "bazel_worker_api")/bazel_dep(name = "bazel_worker_api", version = "'${VER}'")/' java/MODULE.bazel
git commit -am "Release ${VER}"
git archive --format=tar --prefix=bazel-worker-api-${VER}/ `git rev-parse HEAD` \
  java proto ':!:*/.bazelversion' | gzip > bazel-worker-api-v${VER}.tar.gz
git reset --hard HEAD^
