({
    Entity: {},

    name: { type: 'string', length: { min: 8, max: 64 }},
    age: 'date',
    occupation: { many: 'Occupation' },
    group: { many: 'Group' },
});
