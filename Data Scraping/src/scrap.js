// scrap.js
// Main program to perform data scraping

/*
    August, 2025.

    The program is designed by Rasyid Rizky Susilo Nurdwiputro (18221048@std.stei.itb.ac.id) to scrape data
    from Fandom's Villains Wiki, specifically targeting Manga Villains and their related attributes.
    It follows the rules and guidelines outlined in Fandom's "robots.txt" file
    (https://villains.fandom.com/robots.txt) for automated access. This ensures that the program
    operates within the permitted boundaries set by Fandom, avoiding any disruptive or
    unauthorized scraping activities.

    To further respect the site's traffic and prevent overwhelming their servers, the program
    incorporates a deliberate delay of 2 second between each request. This delay helps to reduce
    the load on Fandom's infrastructure and ensures a more considerate and balanced approach
    to data retrieval.

    Additionally, the program respects the access policies defined in the site's "robots.txt" file
    (https://villains.fandom.com/robots.txt), ensuring that only publicly permitted and static content
    is accessed during the scraping process. This prevents the program from interacting with any
    restricted or sensitive endpoints, and helps maintain responsible and ethical scraping practices.
*/

// Import required libraries and custom modules for data retrieval.
const path = require('path');
require('dotenv').config({ path: path.resolve(__dirname, '../../.env') }); // Load the environment variables from the .env file
const cron = require('node-cron'); 
const fs = require('fs');
const cronstrue = require('cronstrue');

const { moveFiles } = require('./utility');
const { getVillainList, getVillainDetails } = require('./villainService');

// Define the delay (in milliseconds) between each character/villain to Villains Wiki
const delayMilliseconds = 1000;

// Define the number of characters/villains to be taken from each letter of the alphabet
const char_per_letter = 1;

// Define the auto_schedule flag to control online or offline data retrieval
const auto_schedule = process.env.AUTO_SCHEDULE === 'true';

// Define the parsing schedule to determine the data collection interval.
const cron_schedule = process.env.CRON_SCHEDULE || '* * * * *'; // Default: '* * * *' (every minute)

const output_latest = './Data Scraping/data/latest'; // Define the address for data collection output
const output_old = './Data Scraping/data/old'; // Define the address for data collection transfer

let isRunning = false; // Define lock flag to prevent overlapping

// Main function to parse and retrive the data from Villains Wiki
async function runScraping() {
  if (!isRunning) {
    isRunning = true;

    const starttime = new Date().toLocaleString();
    console.log(`[${starttime}] Starting data scraping...`);

    // Check & move old data to specified address for backups
    if (fs.existsSync(output_latest)) {
      moveFiles(output_latest, output_old);
      console.log('Moving old data to a safe place...')
    }
    else {
      fs.mkdirSync(output_latest, { recursive: true });
    }

    // Retrieve and write raw characters/villains data into a list
    const villain_list = await getVillainList(char_per_letter);
    console.log(`Retrieving a total of ${villain_list.length} villain(s)`);

    // Retrieve and write details of characters/villains to JSON files per category
    await getVillainDetails(villain_list, delayMilliseconds, output_latest);
    const endtime = new Date().toLocaleString();
    console.log(`[${endtime}] Data scraping has been completed\n`);

    isRunning = false;
  }
}

// Call the runScraping function to start data retrieval
runScraping();

// Check & run automated scheduling
if (auto_schedule) {
  let schedule = '';

  try {
    schedule = cronstrue.toString(cron_schedule);
  } 
  catch (err) {
    schedule = `[ERROR] ("${cron_schedule}") isn't a valid Cron pattern`;
  }

  console.log(`[DEBUG] Automated Schedule is active for ${schedule}\n`);
  cron.schedule(cron_schedule, runScraping);
}