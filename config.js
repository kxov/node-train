'use strict';

module.exports = {
    static: {
        port: 8000,
        root: './static'
    },
    api: {
        port: 8001,
        root: './api'
    },
    transport: 'ws',
    logger: 'pino',
    sandbox: {
        timeout: 5000,
        displayErrors: false,
    },
    db: {
        host: '127.0.0.1',
        port: 5432,
        database: 'example',
        user: 'marcus',
        password: 'marcus',
    }
};
