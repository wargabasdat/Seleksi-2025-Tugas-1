// convertsql.js
// Inserting data from .json files in a form of SQL

// Import required libraries
const fs = require('fs');

// Define data paths
const files = {
  evil_doers: './Data Scraping/data/latest/evil_doers.json',
  evil_organizations: './Data Scraping/data/latest/evil_organizations.json',
  evil_families: './Data Scraping/data/latest/evil_families.json',
  hostile_species: './Data Scraping/data/latest/hostile_species.json'
};

// Define .sql address
const outputPath = './Data Storing/export/mangavillain.sql';

// Define SQL Query
let sqlQuery = 'BEGIN;\n';

// Create the necessary tables
sqlQuery += `
CREATE TABLE IF NOT EXISTS Villain (
  name TEXT PRIMARY KEY,
  category TEXT
);

CREATE TABLE IF NOT EXISTS Villain_FullName (
  name TEXT,
  fullname TEXT,
  PRIMARY KEY (name, fullname),
  FOREIGN KEY (name) REFERENCES Villain(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Villain_Alias (
  name TEXT,
  alias TEXT,
  PRIMARY KEY (name, alias),
  FOREIGN KEY (name) REFERENCES Villain(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Villain_Crime (
  name TEXT,
  crime TEXT,
  PRIMARY KEY (name, crime),
  FOREIGN KEY (name) REFERENCES Villain(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Villain_Goal (
  name TEXT,
  goal TEXT,
  PRIMARY KEY (name, goal),
  FOREIGN KEY (name) REFERENCES Villain(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Villain_Origin (
  name TEXT,
  origin TEXT,
  PRIMARY KEY (name, origin),
  FOREIGN KEY (name) REFERENCES Villain(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Villain_Type (
  name TEXT,
  type_of_villain TEXT,
  PRIMARY KEY (name, type_of_villain),
  FOREIGN KEY (name) REFERENCES Villain(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Evil_Doer (
  name TEXT PRIMARY KEY,
  FOREIGN KEY (name) REFERENCES Villain(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS ED_Occupation (
  name TEXT,
  occupation TEXT,
  PRIMARY KEY (name, occupation),
  FOREIGN KEY (name) REFERENCES Evil_Doer(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS ED_Power (
  name TEXT,
  power TEXT,
  PRIMARY KEY (name, power),
  FOREIGN KEY (name) REFERENCES Evil_Doer(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Evil_Organization (
  name TEXT PRIMARY KEY,
  foundation TEXT,
  FOREIGN KEY (name) REFERENCES Villain(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS EO_Agent (
  name TEXT,
  agent TEXT,
  PRIMARY KEY (name, agent),
  FOREIGN KEY (name) REFERENCES Evil_Organization(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS EO_Commander (
  name TEXT,
  commander TEXT,
  PRIMARY KEY (name, commander),
  FOREIGN KEY (name) REFERENCES Evil_Organization(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS EO_Headquarter (
  name TEXT,
  headquarter TEXT,
  PRIMARY KEY (name, headquarter),
  FOREIGN KEY (name) REFERENCES Evil_Organization(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS EO_Power (
  name TEXT,
  power TEXT,
  PRIMARY KEY (name, power),
  FOREIGN KEY (name) REFERENCES Evil_Organization(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Evil_Family (
  name TEXT PRIMARY KEY,
  home_base_of_operations TEXT,
  patriarch TEXT,
  matriarch TEXT,
  FOREIGN KEY (name) REFERENCES Villain(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS EF_Member (
  name TEXT,
  member TEXT,
  PRIMARY KEY (name, member),
  FOREIGN KEY (name) REFERENCES Evil_Family(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Hostile_Species (
  name TEXT PRIMARY KEY,
  homeworld TEXT,
  FOREIGN KEY (name) REFERENCES Villain(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS HS_Member (
  name TEXT,
  relative_member TEXT,
  PRIMARY KEY (name, relative_member),
  FOREIGN KEY (name) REFERENCES Hostile_Species(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS HS_Abilities (
  name TEXT,
  ability TEXT,
  PRIMARY KEY (name, ability),
  FOREIGN KEY (name) REFERENCES Hostile_Species(name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
\n`;

// Utility helper
const escape = (text) => {
  if (text === null || text === undefined || String(text).trim() === '') {
    return 'NULL';
  }
  return `'${String(text)
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^\x00-\x7F]/g, '')
    .replace(/'/g, "''")
    .trim()}'`;
};

/**
 * function insertVillain
 * Retrieve name, category from each villain & store it inside Villain table
 * @param base: node 
 * @param type: string
 */
function insertVillain(base, villain_category) {
  const name = escape(base.name || '');
  const category = escape(villain_category);

  sqlQuery += `INSERT INTO Villain (name, category) VALUES (${name}, ${category});\n`;
}

/**
 * function insertMany
 * Retrieve additional attributes from each villain & store it inside to appropriate table
 * @param table: string 
 * @param field: string
 * @param values: string
 * @param name: string
 */
function insertMany(table, field, values, name) {
  if (values) {
    let items = [];

    if (Array.isArray(values)) {
        items = values;
    } 
    else if (typeof values === 'string') {
        items = values.split(/[,;]\s*/);
    } 
    else {
        items = [values];
    }

    items.map(v => v.trim()).filter(Boolean).forEach(val => {
        sqlQuery += `INSERT INTO ${table} (name, ${field}) VALUES (${escape(name)}, ${escape(val)});\n`;
    });
  }
}

// Main program to start converting data
for (const [category, filepath] of Object.entries(files)) {
  const raw = fs.readFileSync(filepath, 'utf-8');
  const json = JSON.parse(raw);
  const list = json.data;

  // Loop for each villain data
  list.forEach(entry => {
    const name = entry.name;

    // Insert base data on villain
    insertVillain(entry, category);
    insertMany('Villain_Type', 'type_of_villain', entry.type_of_villain || entry.type_of_villains || entry.type_of_hostile_species, name);
    insertMany('Villain_Origin', 'origin', entry.origin, name);
    insertMany('Villain_FullName', 'fullname', entry.fullname, name);
    insertMany('Villain_Alias', 'alias', entry.alias, name);
    insertMany('Villain_Crime', 'crime', entry.crimes, name);
    insertMany('Villain_Goal', 'goal', entry.goals, name);

    // Insert addtional details on villain by category
    if (category === 'evil_doers') {
      sqlQuery += `INSERT INTO Evil_Doer (name) VALUES (${escape(name)});\n`;
      insertMany('ED_Occupation', 'occupation', entry.occupation, name);
      insertMany('ED_Power', 'power', entry.skills || entry.powers, name);
    }
    else if (category === 'evil_organizations') {
      sqlQuery += `INSERT INTO Evil_Organization (name, foundation) VALUES (${escape(name)}, ${escape(entry.foundation || '')});\n`;
      insertMany('EO_Agent', 'agent', entry.agents, name);
      insertMany('EO_Commander', 'commander', entry.commanders, name);
      insertMany('EO_Headquarter', 'headquarter', entry.headquarters, name);
      insertMany('EO_Power', 'power', entry.skills, name);
    }
    else if (category === 'evil_families') {
      sqlQuery += `INSERT INTO Evil_Family (name, home_base_of_operations, patriarch, matriarch) VALUES (
        ${escape(name)},
        ${escape(entry.home_base_of_operations || '')},
        ${escape(entry.patriarch || '')},
        ${escape(entry.matriarch || '')}
      );\n`;
      insertMany('EF_Member', 'member', entry.relatives_members, name);
    }
    else if (category === 'hostile_species') {
      sqlQuery += `INSERT INTO Hostile_Species (name, homeworld) VALUES (${escape(name)}, ${escape(entry.homeworld || '')});\n`;
      insertMany('HS_Member', 'relative_member', entry.members, name);
      insertMany('HS_Abilities', 'ability', entry.abilities, name);
    }
  });
}

sqlQuery += '\nCOMMIT;\n';

fs.writeFileSync(outputPath, '\ufeff' + sqlQuery, { encoding: 'utf8' });
console.log(`[DEBUG] SQL file successfully added to: ${outputPath}`);
