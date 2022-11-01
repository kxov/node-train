module.exports = ({ db }) => {

  const countryRepository = db('country');

  return {
    read(id) {
      return countryRepository.read(id);
    },

    find(mask) {
      const sql = 'SELECT * from country where name like $1';
      return countryRepository.query(sql, [mask]);
    },
  }
};
