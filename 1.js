const s = {
    user: {
        create: ['record'],
        read: ['id'],
        update: ['id', 'record'],
        delete: ['id'],
        find: ['mask'],
    },
    country: {
        read: ['id'],
        delete: ['id'],
        find: ['mask'],
    },
};

for (const k of Object.keys(s)) {
    console.log(k);
}

const logger = require('pino')()

logger.info('hello world')

logger.log('h1')
