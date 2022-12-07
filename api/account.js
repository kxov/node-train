module.exports = ({ db, common }) => {

  const accountRepository = db('Account');

  return {
    read(id) {
      return accountRepository.read(id, ['accountId', 'login']);
    },

    async create({ login, password }) {
      const passwordHash = await common.hash(password);
      return accountRepository.create({ login, password: passwordHash });
    },

    async update(id, { login, password }) {
      const passwordHash = await common.hash(password);
      return accountRepository.update(id, { login, password: passwordHash });
    },

    delete(id) {
      return accountRepository.delete(id);
    },

    find(mask) {
      const sql = 'SELECT login from Account where login like $1';
      return accountRepository.query(sql, [mask]);
    },
  }
}
