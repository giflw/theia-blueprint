'use strict';

import fs from 'fs';
import fetch from 'node-fetch';

const plugins = JSON.parse(fs.readFileSync('plugins.package.json'));

async function get(url) {
	let response = await fetch(url);
	if (response.status !== 200) {
		process.exit(1);
	}
	return await response.json();
}


async function updatePluginVersion(plugin, url) {
	plugin = plugin.replace('.', '/');
	url = url || `https://open-vsx.org/api/${plugin}/latest`;
	url = url.split('/file/')[0];
	console.log('======');
	console.log(plugin, '=>', url);

	let data = await get(url);
	
	let version = '';
	for(version in data.allVersions) {
		if (!version.includes('next') && !version.includes('latest')) {
			break;
		}
	}
	url = data.allVersions[version];
	data = await get(url);
	url = data.files.download;
	console.log(plugin.split('').map(c => ' ').join(''), '=>', url);
	
	return url;
};


for(let plugin in plugins.theiaPlugins) {
	const url = await updatePluginVersion(plugin, plugins.theiaPlugins[plugin]);
	plugins.theiaPlugins[plugin] = url;
}

console.log('=============');
console.log(plugins);
fs.writeFileSync('plugins.package.json', JSON.stringify(plugins, null, 2));

