# Build theia as portable
#
# MUST be run from project root directory
#

cd eos-thesis-ide
node ./update-plugins.mjs
cd ..

rm -r -f applications/electron/plugins/

yarn electron clean:dist
yarn electron clean
yarn clean

npx --yes json-merger --pretty  ./applications/electron/package.json            \
                                ./eos-thesis-ide/plugins.package.json           \
                                ./eos-thesis-ide/plugins-opiniated.package.json \
                                --output ./applications/electron/package.json

npx --yes json-merger --pretty  ./applications/electron/package.json            \
                                ./eos-thesis-ide/dependencies.package.json      \
                                --output ./applications/electron/package.json

yarn
yarn electron download:plugins
yarn build
yarn electron package
