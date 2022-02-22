# 🐋 pre-commit Docker Image

This docker image provides pre-commit with some other potential dependencies pre-installed. It is used in CI environments where we want to have a working install of pre-commit available quickly.

## 📦 Additional dependencies

- NodeJS LTS

## ⚙ Running

To test a directory run

```
docker run --rm -v $(pwd):/test pre-commit
```

The mounted directory must be a git repository and contain the `.git` directory.

## ⌛ Caching environments

pre-commit creates virtual environments for each check. To cache these between builds you should persist the `/pre-commit-cache` directory.

## 🦊 Use in GitLab CI

```
pre-commit:
  stage: test
  image: ghcr.io/wegift/pre-commit:master
  cache:
    - key:
        files:
          - pre-commit-config.yaml
      paths:
        - /pre-commit-cache
  script:
    - pre-commit run --all-files --show-diff-on-failure
```

## 🛫 Releasing

To make a new release create a tag with the desired version. We **do not** prefix the version number with `v` as this is the standard within the Docker ecosystem.

```
git tag -am "<description>" X.Y.Z
git push origin X.Y.Z
```

Then [create a release in GitHub](https://github.com/wegift/pre-commit/releases/new) for this tag. CI will then run and publish the version to [GHCR](https://github.com/wegift/pre-commit/pkgs/container/pre-commit).
