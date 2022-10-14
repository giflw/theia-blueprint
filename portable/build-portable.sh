# Build theia as portable
#
# MUST be run from project root directory
#

yarn electron clean:dist
yarn electron clean
yarn clean
yarn

cp ./applications/electron/package.json ./applications/electron/package.json.orig
npx --yes json-merger --pretty ./applications/electron/package.json ./portable/plugins.package.json --output ./applications/electron/package.json

yarn build
yarn electron package

cp ./applications/electron/package.json ./applications/electron/package.json.new
cp ./applications/electron/package.json.orig ./applications/electron/package.json 
