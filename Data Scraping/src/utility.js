// utility.js
// Provide functions to help retrieving & storing parse data

// Import required libraries
const fs = require('fs');
const path = require('path');

/**
 * function trimText
 * Remove whitespace for a string
 * @param text: string
 * @returns string or null
 */
function trimText(text) {
  if (!text || typeof text !== 'string') {
    return null;
  }
  else {
    return text
      .replace(/\n+/g, ' ')
      .replace(/\t+/g, ' ')
      .replace(/\s\s+/g, ' ')
      .replace(/[\u200B-\u200D\uFEFF]/g, '')
      .trim();
  }
}

/**
 * function trimObject
 * Remove whitespace for an object
 * @param obj: object
 * @returns object
 */
function trimObject(obj) {
  const clean = {};

  for (const key in obj) {
    if (typeof obj[key] === 'string') {
      clean[key] = trimText(obj[key]);
    } 
    else {
      clean[key] = obj[key]; // object is not a string (array, null, etc.)
    }
  }

  return clean;
}

/**
 * function identifyCategory
 * Define a villain category based on heading or infoboxTitle
 * @param $: CheerioStatic
 * @returns 'evil_doers' or 'evil_organizations' or 'evil_families' or 'hostile_species'
 */
function identifyCategory($) {
  const heading = $('h2 span.mw-headline').first().text().toLowerCase();
  const infoboxTitle = $('aside.portable-infobox h2.pi-item').first().text().toLowerCase();

  if (heading.includes('organization') || infoboxTitle.includes('organization')) return 'evil_organizations';
  else if (heading.includes('family') || infoboxTitle.includes('family')) return 'evil_families';
  else if (heading.includes('species') || infoboxTitle.includes('species')) return 'hostile_species';
  else return 'evil_doers';
}

/**
 * function extractAttributes
 * Extract all information (name, origin, etc.) from a villain page into an object
 * @param $: CheerioStatic
 * @returns object
 */
function extractAttributes($) {
  const attributes = {};

  // Process the contents of HTML nodes and extract clean text from them
  const extractLines = ($node) => {
    const rawText = $node
      .clone()
      .find('small').remove().end()
      .html()
      .replace(/<br\s*\/?>/gi, '\n')
      .replace(/<\/p>/gi, '\n')
      .replace(/<[^>]+>/g, '')
      .replace(/[\u200B-\u200D\uFEFF]/g, '')
      .trim();

    if (!rawText) {
      return null;
    }
    else {
      const lines = rawText.split('\n')
        .map(trimText)
        .filter(Boolean);

      return lines.length > 1 ? lines : lines[0];
    }
  };

  // Loop for each HTML attribute
  $('div.pi-data[data-source]').each((_, el) => {
    // Retrieve key and value
    const key = $(el).attr('data-source');
    const valueNode = $(el).find('.pi-data-value').first();
    const value = extractLines(valueNode);

    // Validate and normalize key & value
    if (!key || !value || (typeof value === 'string' && (value === 'No information' || value === 'None' || value === 'Unknown'))) return null;
    else {
      const normalizedKey = key
        .toLowerCase()
        .replace(/[\s/]+/g, '_')
        .replace(/_+/g, '_')
        .replace(/^_+|_+$/g, '');

      attributes[normalizedKey] = value;
    }
  });

  return attributes;
}

/**
 * function moveFiles
 * Move the file to the specified address and replace the old file if it exists
 * @param $: CheerioStatic
 * @returns object
 */
function moveFiles(srcDir, backupDir) {
  if (fs.existsSync(srcDir)) {

    // Check existing address
    if (!fs.existsSync(backupDir)) fs.mkdirSync(backupDir, { recursive: true }); // if backupDir isn't exist, make a folder in backupDir

    // Move every file from srcDir to destPath
    fs.readdirSync(srcDir).forEach(file => {
      const srcPath = path.join(srcDir, file);
      const destPath = path.join(backupDir, `${file}`);
      fs.renameSync(srcPath, destPath);
    });
  }
}

// Export utility functions to be used in other modules
module.exports = {
  trimText,
  trimObject,
  identifyCategory,
  extractAttributes,
  moveFiles,
};
