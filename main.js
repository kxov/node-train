'use strict';

const config = require('./config.js');

const fsp = require('fs').promises;
const path = require('path');

const logger = config.logger === 'native' ? require('./logger.js') : require('pino')();

const server = require(`./${config.transport}.js`)(logger);
const staticServer = require('./static.js');
const load = require('./load.js');
const db = require('./db.js')(config.db);
const hash = require('./hash.js');

const sandbox = {
  console: Object.freeze(logger),
  db: Object.freeze(db),
  common: { hash },
};
const apiPath = path.join(process.cwd(), config.api.path);
const routing = {};

(async () => {
  const files = await fsp.readdir(apiPath);
  for (const fileName of files) {
    if (!fileName.endsWith('.js')) continue;
    const filePath = path.join(apiPath, fileName);
    const serviceName = path.basename(fileName, '.js');
    routing[serviceName] = await load(config.sandbox)(filePath, sandbox);
  }

  staticServer(config.static.path, config.static.port);
  server(routing, config.api.port);
})();
