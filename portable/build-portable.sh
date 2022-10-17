# Build theia as portable
#
# MUST be run from project root directory
#

cd portable
node ./update-plugins.mjs
cd ..

rm -r -f applications/electron/plugins/

yarn electron clean:dist
yarn electron clean
yarn clean

cp ./applications/electron/package.json ./applications/electron/package.json.orig
npx --yes json-merger --pretty ./applications/electron/package.json ./portable/plugins.package.json --output ./applications/electron/package.json

yarn
yarn electron download:plugins
yarn build
yarn electron package

cp ./applications/electron/package.json ./applications/electron/package.json.new
cp ./applications/electron/package.json.orig ./applications/electron/package.json 
