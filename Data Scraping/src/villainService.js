// villainService.js
// Side-program to extract data from Villains Wiki page

// Import required libraries and custom modules for data retrieval.
require('dotenv').config();
const axios = require('axios');
const cheerio = require('cheerio');
const fs = require('fs');
const path = require('path');

const { identifyCategory, extractAttributes, trimObject } = require('./utility');

// Define the base url for Villains Wiki
const BASE_URL = process.env.BASE_URL;

// Define the child url for Manga Villains Wiki
const CATEGORY_PATH = process.env.CATEGORY_PATH;

// Define user agent for data retriever
const USER_AGENT = process.env.USER_AGENT;

const HEADERS = {
  'User-Agent': USER_AGENT,
};

// Define the category of villains whose data will be retrieved and saved in the specified file.
const TYPE_MAP = {
  evil_doers: 'evil_doers.json',
  evil_organizations: 'evil_organizations.json',
  evil_families: 'evil_families.json',
  hostile_species: 'hostile_species.json',
};

/**
 * function getVillainList
 * Retrieve an array of raw data (name, url) for each villains (A-Z)
 * @param limitPerLetter: int (default = 1)
 * @returns array of (name, url) tuple
 */
async function getVillainList(limitPerLetter = 1) {
  const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
  const result = [];

  // Extract limitPerLetter characters/villains for each letter of the alphabet 
  for (const letter of alphabet) {
    // Make an url for each letter of the alphabet
    const url = `${BASE_URL}${CATEGORY_PATH}?from=${letter}`;
    try {

      // Fetch dan scrape data
      const { data } = await axios.get(url, { headers: HEADERS });
      const $ = cheerio.load(data);
      const links = $('a.category-page__member-link');

      // Retrieve the name & url of each villain
      links.each((i, el) => {
        if (limitPerLetter && i >= limitPerLetter) return false;
        else {
          const name = $(el).text().trim();

          if (!name.startsWith('Category:')) {
            result.push({
              name,
              url: `${BASE_URL}${$(el).attr('href')}`,
            });
          }
        }
      });
    } 
    catch (err) {
      console.error(`[ERROR] ${letter} character:`, err.message);
    }
  }

  return result;
}

/**
 * function getVillainDetails
 * Retrieve additional data for each villains and store it in an array based on their category
 * @param villainList: array of (name: string, url: string) tuple
 * @param delayMs: int (default = 2000 ms)
 * @param outputFolder: string
 */
async function getVillainDetails(villainList, delayMs = 2000, outputFolder) {
  // Define arrays for each villain category
  const result = {
    evil_doers: [],
    evil_organizations: [],
    evil_families: [],
    hostile_species: [],
  };

  // Extract additional data for each villain in villainList
  for (let i = 0; i < villainList.length; i++) {
    const villain = villainList[i];
    console.log(`[${i + 1}/${villainList.length}] Scraping: ${villain.name}`);

    try {
      // Fetch & extract details for a villain
      const { data } = await axios.get(villain.url, { headers: HEADERS });
      const $ = cheerio.load(data);

      // Identify & extract attribute
      const type = identifyCategory($); // 'evil_doers', etc.
      const rawAttributes = extractAttributes($);
      const attributes = trimObject(rawAttributes);

      // Store cleaned data to result
      result[type].push({
        name: villain.name,
        url: villain.url,
        ...attributes,
      });
    } 
    catch (err) {
      console.error(`[ERROR] Failed retrieve ${villain.name}:`, err.message);
    }

    // Pause execution for a given number of milliseconds
    await new Promise((r) => setTimeout(r, delayMs));
  }

  // Add data retrieval timestamp for each category files
  const timestamp = new Date().toLocaleString();

  // Store data collection to specified files based on the villain categories
  for (const [type, filename] of Object.entries(TYPE_MAP)) {
    const filepath = path.join(outputFolder, filename);
    const dataWithTimestamp = {
      timestamp,
      data: result[type]
    };
    fs.writeFileSync(filepath, JSON.stringify(dataWithTimestamp, null, 2));
    console.log(`[DEBUG] Saved ${type} in: ${filepath}`);
  }
}

// Export functions to be used in other modules
module.exports = {
  getVillainList,
  getVillainDetails,
};
