'use strict';

const transport = {};

const serviceIterator = (structure, callback) => {
  const api = {};
  const services = Object.keys(structure);
  for (const name of services) {
    api[name] = {};
    const service = structure[name];
    const methods = Object.keys(service);
    for (const method of methods) {
      api[name][method] = callback(name, method);
    }
  }

  return api;
};

transport.http = (url) => (structure) => {
  const api = serviceIterator(structure,
      (name, method) => (...args) => new Promise((resolve, reject) => {
    fetch(`${url}/${name}/${method}/${args.join('')}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ args }),
    }).then((res) => {
      if (res.status === 200) resolve(res.json());
      else reject(new Error(`Status Code: ${res.status}`));
    });
  }));

  return Promise.resolve(api);
};

transport.ws = (url) => (structure) => {
  const socket = new WebSocket(url);

  const api = serviceIterator(structure,
      (name, method) => (...args) => new Promise((resolve) => {
    const packet = { name, method, args };
    socket.send(JSON.stringify(packet));
    socket.onmessage = (event) => {
      const data = JSON.parse(event.data);
      resolve(data);
    };
  }));

  return new Promise((resolve) => {
    socket.addEventListener('open', () => resolve(api));
  });
};

const scaffold = (url) => {
  const protocol = url.startsWith('ws:') ? 'ws' : 'http';
  return transport[protocol](url);
};

(async () => {
  const api = await scaffold('ws://localhost:8001')({
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
    talks: {
      say: ['message'],
    }
  });
  const data = await api.country.read(3);
  console.dir({ data });
})();
