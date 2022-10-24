'use strict';

const config = require('./config.js');

const fsp = require('fs').promises;
const path = require('path');

const transport = require(`./${config.transport}.js`);
const staticServer = require('./static.js');
const load = require('./load.js')(config.sandbox);
const db = require('./db.js')(config.db);
const hash = require('./hash.js');

const loggers = {
  node: console,
  fs: require('./logger.js'),
  pino: require('pino')(),
};

const sandbox = {
  console: Object.freeze(loggers[config.logger]),
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
    routing[serviceName] = await load(filePath, sandbox);
  }

  staticServer(config.static.path, config.static.port, sandbox.console);
  transport(routing, config.api.port, sandbox.console);
})();
