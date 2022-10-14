'use strict';

const wsPromise = (serviceName, methodName, args, socket) => {
  return new Promise((resolve) => {
    const packet = { name: serviceName, method: methodName, args };
    socket.send(JSON.stringify(packet));
    socket.onmessage = (event) => {
      const data = JSON.parse(event.data);
      resolve(data);
    };
  });
};

const httpPromise = (serviceName, methodName, args, uri) => {
  return new Promise((resolve, reject) => {
    const url = `${uri}${serviceName}/${methodName}/${args.join('')}`;
    console.log(url, args);
    fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(args),
    }).then((res) => {
      const { status } = res;
      if (status !== 200) {
        reject(new Error(`Status Code: ${status}`));
        return;
      }
      resolve(res.json());
    });
  });
};

const scaffold = (url, structure) => {
  const api = {};
  const isHttp = url.charAt(0) === 'h';

  const socket = isHttp ? null : new WebSocket(url);

  const services = Object.keys(structure);
  for (const serviceName of services) {
    api[serviceName] = {};
    const service = structure[serviceName];
    const methods = Object.keys(service);
    for (const methodName of methods) {
      api[serviceName][methodName] = (...args) => isHttp ?
          httpPromise(serviceName, methodName, args, url) : wsPromise(serviceName, methodName, args, socket)
    }
  }
  return { api, socket };
};

const { api, socket } = scaffold('ws://127.0.0.1:8001/', {
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
});

socket.addEventListener('open', async () => {
  const data = await api.country.read(3);
  console.dir({ data });
});

// const run = async () => {
//   const data = await api.user.read(3);
//   console.dir({ data });
// };
//
// run();


