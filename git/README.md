```sh
# Checkout with submodules
git submodule update --init --recursive

# create / delete tags 
git tag v24.52.0
git push origin v24.52.0

git push --delete origin v24.52.0 # remote
git tag --delete v24.52.0 # local

```