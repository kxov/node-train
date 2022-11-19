({
    Entity: {},

    name: { type: 'string', length: { min: 8, max: 64 }},
    age: { type: 'number', length: { min: 0, max: 100 } },
    occupation: { many: 'Occupation' },
    group: { many: 'Group' },
});
