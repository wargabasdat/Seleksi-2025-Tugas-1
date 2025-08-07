BEGIN;

CREATE TABLE IF NOT EXISTS Villain (
  name TEXT PRIMARY KEY,
  category TEXT
);

CREATE TABLE IF NOT EXISTS Villain_FullName (
  name TEXT,
  fullname TEXT,
  PRIMARY KEY (name, fullname),
  FOREIGN KEY (name) REFERENCES Villain(name)
);

CREATE TABLE IF NOT EXISTS Villain_Alias (
  name TEXT,
  alias TEXT,
  PRIMARY KEY (name, alias),
  FOREIGN KEY (name) REFERENCES Villain(name)
);

CREATE TABLE IF NOT EXISTS Villain_Crime (
  name TEXT,
  crime TEXT,
  PRIMARY KEY (name, crime),
  FOREIGN KEY (name) REFERENCES Villain(name)
);

CREATE TABLE IF NOT EXISTS Villain_Goal (
  name TEXT,
  goal TEXT,
  PRIMARY KEY (name, goal),
  FOREIGN KEY (name) REFERENCES Villain(name)
);

CREATE TABLE IF NOT EXISTS Villain_Origin (
  name TEXT,
  origin TEXT,
  PRIMARY KEY (name, origin),
  FOREIGN KEY (name) REFERENCES Villain(name)
);

CREATE TABLE IF NOT EXISTS Villain_Type (
  name TEXT,
  type_of_villain TEXT,
  PRIMARY KEY (name, type_of_villain),
  FOREIGN KEY (name) REFERENCES Villain(name)
);

CREATE TABLE IF NOT EXISTS Evil_Doer (
  name TEXT PRIMARY KEY,
  FOREIGN KEY (name) REFERENCES Villain(name)
);

CREATE TABLE IF NOT EXISTS ED_Occupation (
  name TEXT,
  occupation TEXT,
  PRIMARY KEY (name, occupation),
  FOREIGN KEY (name) REFERENCES Evil_Doer(name)
);

CREATE TABLE IF NOT EXISTS ED_Power (
  name TEXT,
  power TEXT,
  PRIMARY KEY (name, power),
  FOREIGN KEY (name) REFERENCES Evil_Doer(name)
);

CREATE TABLE IF NOT EXISTS Evil_Organization (
  name TEXT PRIMARY KEY,
  foundation TEXT,
  FOREIGN KEY (name) REFERENCES Villain(name)
);

CREATE TABLE IF NOT EXISTS EO_Agent (
  name TEXT,
  agent TEXT,
  PRIMARY KEY (name, agent),
  FOREIGN KEY (name) REFERENCES Evil_Organization(name)
);

CREATE TABLE IF NOT EXISTS EO_Commander (
  name TEXT,
  commander TEXT,
  PRIMARY KEY (name, commander),
  FOREIGN KEY (name) REFERENCES Evil_Organization(name)
);

CREATE TABLE IF NOT EXISTS EO_Headquarter (
  name TEXT,
  headquarter TEXT,
  PRIMARY KEY (name, headquarter),
  FOREIGN KEY (name) REFERENCES Evil_Organization(name)
);

CREATE TABLE IF NOT EXISTS EO_Power (
  name TEXT,
  power TEXT,
  PRIMARY KEY (name, power),
  FOREIGN KEY (name) REFERENCES Evil_Organization(name)
);

CREATE TABLE IF NOT EXISTS Evil_Family (
  name TEXT PRIMARY KEY,
  home_base_of_operations TEXT,
  patriarch TEXT,
  matriarch TEXT,
  FOREIGN KEY (name) REFERENCES Villain(name)
);

CREATE TABLE IF NOT EXISTS EF_Member (
  name TEXT,
  member TEXT,
  PRIMARY KEY (name, member),
  FOREIGN KEY (name) REFERENCES Evil_Family(name)
);

CREATE TABLE IF NOT EXISTS Hostile_Species (
  name TEXT PRIMARY KEY,
  homeworld TEXT,
  FOREIGN KEY (name) REFERENCES Villain(name)
);

CREATE TABLE IF NOT EXISTS HS_Member (
  name TEXT,
  relative_member TEXT,
  PRIMARY KEY (name, relative_member),
  FOREIGN KEY (name) REFERENCES Hostile_Species(name)
);

CREATE TABLE IF NOT EXISTS HS_Abilities (
  name TEXT,
  ability TEXT,
  PRIMARY KEY (name, ability),
  FOREIGN KEY (name) REFERENCES Hostile_Species(name)
);

INSERT INTO Villain (name, category) VALUES ('A (Bungo Stray Dogs)', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('A (Bungo Stray Dogs)', 'Sadistic Gambler');
INSERT INTO Villain_Origin (name, origin) VALUES ('A (Bungo Stray Dogs)', 'Bungo Stray Dogs');
INSERT INTO Villain_Alias (name, alias) VALUES ('A (Bungo Stray Dogs)', 'A');
INSERT INTO Villain_Alias (name, alias) VALUES ('A (Bungo Stray Dogs)', 'Ace');
INSERT INTO Villain_Crime (name, crime) VALUES ('A (Bungo Stray Dogs)', 'Murder');
INSERT INTO Villain_Crime (name, crime) VALUES ('A (Bungo Stray Dogs)', 'Coercion');
INSERT INTO Villain_Crime (name, crime) VALUES ('A (Bungo Stray Dogs)', 'Attempted treason');
INSERT INTO Villain_Crime (name, crime) VALUES ('A (Bungo Stray Dogs)', 'Kidnapping');
INSERT INTO Villain_Crime (name, crime) VALUES ('A (Bungo Stray Dogs)', 'Assault');
INSERT INTO Villain_Crime (name, crime) VALUES ('A (Bungo Stray Dogs)', 'Organized crime');
INSERT INTO Villain_Crime (name, crime) VALUES ('A (Bungo Stray Dogs)', 'Blackmail');
INSERT INTO Villain_Crime (name, crime) VALUES ('A (Bungo Stray Dogs)', 'Abuse');
INSERT INTO Villain_Goal (name, goal) VALUES ('A (Bungo Stray Dogs)', 'Overthrow Ougai Mori');
INSERT INTO Villain_Goal (name, goal) VALUES ('A (Bungo Stray Dogs)', 'Convince Fyodor Dostoyevsky to join him .');
INSERT INTO Evil_Doer (name) VALUES ('A (Bungo Stray Dogs)');
INSERT INTO ED_Occupation (name, occupation) VALUES ('A (Bungo Stray Dogs)', 'Port Mafia executive');
INSERT INTO ED_Power (name, power) VALUES ('A (Bungo Stray Dogs)', 'The Madness of the Jewel King');
INSERT INTO ED_Power (name, power) VALUES ('A (Bungo Stray Dogs)', 'Master gambler');
INSERT INTO Villain (name, category) VALUES ('Ba Nan Ji', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('Ba Nan Ji', 'Thrill Seeking Right-Hand');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('Ba Nan Ji', 'Berserk Military Veteran');
INSERT INTO Villain_Origin (name, origin) VALUES ('Ba Nan Ji', 'Kingdom');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Ba Nan Ji', 'Ba Nan Ji');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Ba Nan Ji', 'Ma Nan Ci');
INSERT INTO Villain_Alias (name, alias) VALUES ('Ba Nan Ji', '');
INSERT INTO Villain_Alias (name, alias) VALUES ('Ba Nan Ji', 'Demon of Ganmon');
INSERT INTO Villain_Alias (name, alias) VALUES ('Ba Nan Ji', 'Iron Hammer of Ganmon');
INSERT INTO Villain_Alias (name, alias) VALUES ('Ba Nan Ji', 'Father');
INSERT INTO Villain_Alias (name, alias) VALUES ('Ba Nan Ji', 'Ba Nan Ji-sama/Lord Ba Nan Ji');
INSERT INTO Villain_Alias (name, alias) VALUES ('Ba Nan Ji', 'Ba Nan Ji-dono');
INSERT INTO Villain_Alias (name, alias) VALUES ('Ba Nan Ji', 'General Ba Nan Ji');
INSERT INTO Villain_Alias (name, alias) VALUES ('Ba Nan Ji', 'General');
INSERT INTO Villain_Alias (name, alias) VALUES ('Ba Nan Ji', 'Old Man');
INSERT INTO Villain_Alias (name, alias) VALUES ('Ba Nan Ji', 'Banana, Banana Man');
INSERT INTO Villain_Alias (name, alias) VALUES ('Ba Nan Ji', 'One Eye');
INSERT INTO Villain_Crime (name, crime) VALUES ('Ba Nan Ji', 'Mass Murder');
INSERT INTO Villain_Crime (name, crime) VALUES ('Ba Nan Ji', 'Treason');
INSERT INTO Villain_Crime (name, crime) VALUES ('Ba Nan Ji', 'Death threats');
INSERT INTO Villain_Crime (name, crime) VALUES ('Ba Nan Ji', 'Attempted Murder');
INSERT INTO Villain_Goal (name, goal) VALUES ('Ba Nan Ji', 'Defend the land of Zhao from invaders.');
INSERT INTO Villain_Goal (name, goal) VALUES ('Ba Nan Ji', 'Defeat and destroy the armies of Qin.');
INSERT INTO Villain_Goal (name, goal) VALUES ('Ba Nan Ji', 'Help Ri Boku in placing Ka as the rightful king of Zhao');
INSERT INTO Villain_Goal (name, goal) VALUES ('Ba Nan Ji', 'Recover strength and one day return to power.');
INSERT INTO Villain_Goal (name, goal) VALUES ('Ba Nan Ji', 'Prevent the state of Qin from taking and conquering the city of Gyou.');
INSERT INTO Villain_Goal (name, goal) VALUES ('Ba Nan Ji', 'Kill Ou Sen.');
INSERT INTO Villain_Goal (name, goal) VALUES ('Ba Nan Ji', 'Kill Ou Hon of the Gyoku Hou and Shin of the Hi Shin Units.');
INSERT INTO Villain_Goal (name, goal) VALUES ('Ba Nan Ji', 'Prevent the death of Chou Ga Ryuu.');
INSERT INTO Villain_Goal (name, goal) VALUES ('Ba Nan Ji', 'Kill A Kou, 1st commander of the Ou Sen Army.');
INSERT INTO Villain_Goal (name, goal) VALUES ('Ba Nan Ji', 'Declare war on the state of Qin.');
INSERT INTO Villain_Goal (name, goal) VALUES ('Ba Nan Ji', 'Defend the lands of Zhao from the Xiongnu.');
INSERT INTO Evil_Doer (name) VALUES ('Ba Nan Ji');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Ba Nan Ji', 'Leader of the Ba Nan Ji Army');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Ba Nan Ji', 'Deputy of the Ri Boku Army');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Ba Nan Ji', 'Vassal of Ri Boku');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Ba Nan Ji', 'General in the Zhao Military');
INSERT INTO ED_Power (name, power) VALUES ('Ba Nan Ji', 'High Intelligence');
INSERT INTO ED_Power (name, power) VALUES ('Ba Nan Ji', 'Superhuman Strength');
INSERT INTO ED_Power (name, power) VALUES ('Ba Nan Ji', 'Superhuman Speed');
INSERT INTO ED_Power (name, power) VALUES ('Ba Nan Ji', 'Superhuman Durability');
INSERT INTO ED_Power (name, power) VALUES ('Ba Nan Ji', 'Superhuman Endurance');
INSERT INTO ED_Power (name, power) VALUES ('Ba Nan Ji', 'Superhuman Reflexes');
INSERT INTO ED_Power (name, power) VALUES ('Ba Nan Ji', 'Combat Specialist');
INSERT INTO ED_Power (name, power) VALUES ('Ba Nan Ji', 'Podao Expertise');
INSERT INTO ED_Power (name, power) VALUES ('Ba Nan Ji', 'Strategy');
INSERT INTO Villain (name, category) VALUES ('C-Kira', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('C-Kira', 'Remorseful Serial Killer');
INSERT INTO Villain_Origin (name, origin) VALUES ('C-Kira', 'The C-Kira Story');
INSERT INTO Villain_Alias (name, alias) VALUES ('C-Kira', 'Cheap Kira');
INSERT INTO Villain_Alias (name, alias) VALUES ('C-Kira', 'C-Kira');
INSERT INTO Villain_Alias (name, alias) VALUES ('C-Kira', 'Kira');
INSERT INTO Villain_Crime (name, crime) VALUES ('C-Kira', 'Mass murder');
INSERT INTO Villain_Crime (name, crime) VALUES ('C-Kira', 'Assisted suicide');
INSERT INTO Villain_Goal (name, goal) VALUES ('C-Kira', 'Kill the elderly of Japan');
INSERT INTO Evil_Doer (name) VALUES ('C-Kira');
INSERT INTO ED_Power (name, power) VALUES ('C-Kira', 'The Death Note');
INSERT INTO Villain (name, category) VALUES ('D (So I''m a Spider, So What?)', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('D (So I''m a Spider, So What?)', 'Hedonistic Control Freak');
INSERT INTO Villain_Origin (name, origin) VALUES ('D (So I''m a Spider, So What?)', 'So I''m a Spider');
INSERT INTO Villain_Origin (name, origin) VALUES ('D (So I''m a Spider, So What?)', 'So What?');
INSERT INTO Villain_FullName (name, fullname) VALUES ('D (So I''m a Spider, So What?)', 'Wakaba Hiiro');
INSERT INTO Villain_Alias (name, alias) VALUES ('D (So I''m a Spider, So What?)', 'D');
INSERT INTO Villain_Alias (name, alias) VALUES ('D (So I''m a Spider, So What?)', 'God of the End');
INSERT INTO Villain_Alias (name, alias) VALUES ('D (So I''m a Spider, So What?)', 'God of Death');
INSERT INTO Villain_Alias (name, alias) VALUES ('D (So I''m a Spider, So What?)', 'Evil God');
INSERT INTO Villain_Alias (name, alias) VALUES ('D (So I''m a Spider, So What?)', 'Queen');
INSERT INTO Villain_Alias (name, alias) VALUES ('D (So I''m a Spider, So What?)', 'Absolute Paradox');
INSERT INTO Villain_Alias (name, alias) VALUES ('D (So I''m a Spider, So What?)', 'Baldy');
INSERT INTO Villain_Crime (name, crime) VALUES ('D (So I''m a Spider, So What?)', 'Soul collection');
INSERT INTO Villain_Crime (name, crime) VALUES ('D (So I''m a Spider, So What?)', 'Mass murder');
INSERT INTO Villain_Crime (name, crime) VALUES ('D (So I''m a Spider, So What?)', 'Malefic');
INSERT INTO Villain_Crime (name, crime) VALUES ('D (So I''m a Spider, So What?)', 'Forced reincarnation');
INSERT INTO Villain_Goal (name, goal) VALUES ('D (So I''m a Spider, So What?)', 'Manage the System and other worlds.');
INSERT INTO Evil_Doer (name) VALUES ('D (So I''m a Spider, So What?)');
INSERT INTO ED_Occupation (name, occupation) VALUES ('D (So I''m a Spider, So What?)', 'Underworld manager');
INSERT INTO ED_Occupation (name, occupation) VALUES ('D (So I''m a Spider, So What?)', 'Administrator');
INSERT INTO ED_Power (name, power) VALUES ('D (So I''m a Spider, So What?)', 'Physical Strength beyond the System');
INSERT INTO ED_Power (name, power) VALUES ('D (So I''m a Spider, So What?)', 'Intelligence');
INSERT INTO ED_Power (name, power) VALUES ('D (So I''m a Spider, So What?)', 'Conjuring');
INSERT INTO ED_Power (name, power) VALUES ('D (So I''m a Spider, So What?)', 'Counter-measure resistance');
INSERT INTO ED_Power (name, power) VALUES ('D (So I''m a Spider, So What?)', 'Dimensional manipulation');
INSERT INTO ED_Power (name, power) VALUES ('D (So I''m a Spider, So What?)', 'Item creation');
INSERT INTO ED_Power (name, power) VALUES ('D (So I''m a Spider, So What?)', 'Aura of terror');
INSERT INTO ED_Power (name, power) VALUES ('D (So I''m a Spider, So What?)', 'Immortality');
INSERT INTO ED_Power (name, power) VALUES ('D (So I''m a Spider, So What?)', 'Telepathy');
INSERT INTO ED_Power (name, power) VALUES ('D (So I''m a Spider, So What?)', 'Darkness');
INSERT INTO ED_Power (name, power) VALUES ('D (So I''m a Spider, So What?)', 'Stealth');
INSERT INTO ED_Power (name, power) VALUES ('D (So I''m a Spider, So What?)', 'Miscellaneous skills');
INSERT INTO Villain (name, category) VALUES ('E.N.D.', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('E.N.D.', 'Dissociative Protagonist');
INSERT INTO Villain_Origin (name, origin) VALUES ('E.N.D.', 'Fairy Tail');
INSERT INTO Villain_FullName (name, fullname) VALUES ('E.N.D.', 'Etherious Natsu Dragneel');
INSERT INTO Villain_Alias (name, alias) VALUES ('E.N.D.', 'E.N.D.');
INSERT INTO Villain_Alias (name, alias) VALUES ('E.N.D.', 'Master E.N.D.');
INSERT INTO Villain_Alias (name, alias) VALUES ('E.N.D.', 'Natsu Dragneel');
INSERT INTO Villain_Alias (name, alias) VALUES ('E.N.D.', 'Natsu');
INSERT INTO Villain_Alias (name, alias) VALUES ('E.N.D.', 'The Strongest, Most Vile Demon in the Book of Zeref');
INSERT INTO Villain_Alias (name, alias) VALUES ('E.N.D.', '[The] Monster');
INSERT INTO Villain_Alias (name, alias) VALUES ('E.N.D.', 'A Superdemon');
INSERT INTO Villain_Alias (name, alias) VALUES ('E.N.D.', 'One of Zeref''s Pathetic Demons');
INSERT INTO Villain_Alias (name, alias) VALUES ('E.N.D.', 'The Destroyer of All, E.N...');
INSERT INTO Villain_Alias (name, alias) VALUES ('E.N.D.', '[Zeref''s] Little Brother');
INSERT INTO Villain_Alias (name, alias) VALUES ('E.N.D.', 'The Ultimate Etherious');
INSERT INTO Villain_Crime (name, crime) VALUES ('E.N.D.', 'Attempted murder');
INSERT INTO Villain_Crime (name, crime) VALUES ('E.N.D.', 'Attempted fratricide');
INSERT INTO Villain_Crime (name, crime) VALUES ('E.N.D.', 'Dark power creation');
INSERT INTO Villain_Goal (name, goal) VALUES ('E.N.D.', 'Kill his brother Zeref Dragneel .');
INSERT INTO Villain_Goal (name, goal) VALUES ('E.N.D.', 'Protect his friends, especially Lucy Heartfilia .');
INSERT INTO Evil_Doer (name) VALUES ('E.N.D.');
INSERT INTO ED_Occupation (name, occupation) VALUES ('E.N.D.', 'Dragon Slayer Wizard');
INSERT INTO ED_Occupation (name, occupation) VALUES ('E.N.D.', 'Fairy Tail Guild Wizard');
INSERT INTO ED_Power (name, power) VALUES ('E.N.D.', 'Intelligence and knowledge');
INSERT INTO ED_Power (name, power) VALUES ('E.N.D.', 'Hand-to-hand combat and fighting skills');
INSERT INTO ED_Power (name, power) VALUES ('E.N.D.', 'Indomitable willpower');
INSERT INTO ED_Power (name, power) VALUES ('E.N.D.', 'Superhuman strength, senses, agility and durability');
INSERT INTO ED_Power (name, power) VALUES ('E.N.D.', 'Flight');
INSERT INTO ED_Power (name, power) VALUES ('E.N.D.', 'Human-Dragon hybrid physiology');
INSERT INTO ED_Power (name, power) VALUES ('E.N.D.', 'Human-Dragon-Demon hybrid physiology');
INSERT INTO ED_Power (name, power) VALUES ('E.N.D.', 'Transformation Magic');
INSERT INTO ED_Power (name, power) VALUES ('E.N.D.', 'Fire Magic');
INSERT INTO ED_Power (name, power) VALUES ('E.N.D.', 'Flame Magic');
INSERT INTO ED_Power (name, power) VALUES ('E.N.D.', 'Fire Dragon Slayer Magic');
INSERT INTO ED_Power (name, power) VALUES ('E.N.D.', 'Flame God Slayer Magic');
INSERT INTO ED_Power (name, power) VALUES ('E.N.D.', 'Time Magic');
INSERT INTO ED_Power (name, power) VALUES ('E.N.D.', 'Curse Power');
INSERT INTO ED_Power (name, power) VALUES ('E.N.D.', 'Curses');
INSERT INTO Villain (name, category) VALUES ('Fabiano', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('Fabiano', 'Honorable Enforcer');
INSERT INTO Villain_Origin (name, origin) VALUES ('Fabiano', 'Edens Zero');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Fabiano', 'Fabiano');
INSERT INTO Villain_Crime (name, crime) VALUES ('Fabiano', 'Participating in a genocidal war');
INSERT INTO Villain_Goal (name, goal) VALUES ('Fabiano', 'Defeat the Nero Empire''s enemies.');
INSERT INTO Evil_Doer (name) VALUES ('Fabiano');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Fabiano', 'Agent of the Nero Empire');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Fabiano', 'Member of the Oceans 6');
INSERT INTO ED_Power (name, power) VALUES ('Fabiano', 'Ether Gear');
INSERT INTO Villain (name, category) VALUES ('Ga''aoqi', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('Ga''aoqi', 'Opportunistic Warmonger');
INSERT INTO Villain_Origin (name, origin) VALUES ('Ga''aoqi', 'Vinland Saga');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Ga''aoqi', 'Ga''aoqi');
INSERT INTO Villain_Crime (name, crime) VALUES ('Ga''aoqi', 'Serial murder');
INSERT INTO Villain_Crime (name, crime) VALUES ('Ga''aoqi', 'Theft');
INSERT INTO Villain_Crime (name, crime) VALUES ('Ga''aoqi', 'Pillaging');
INSERT INTO Villain_Goal (name, goal) VALUES ('Ga''aoqi', 'Pillage the homes from the Nords in order to find a sword.');
INSERT INTO Evil_Doer (name) VALUES ('Ga''aoqi');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Ga''aoqi', 'Warrior for an unknown Tribe');
INSERT INTO ED_Power (name, power) VALUES ('Ga''aoqi', 'Spear-wielding');
INSERT INTO ED_Power (name, power) VALUES ('Ga''aoqi', 'Fighting prowess');
INSERT INTO Villain (name, category) VALUES ('H.N. Elly', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('H.N. Elly', 'Fallen Hero');
INSERT INTO Villain_Origin (name, origin) VALUES ('H.N. Elly', 'Puella Magi Madoka Magica');
INSERT INTO Villain_FullName (name, fullname) VALUES ('H.N. Elly', 'Kirstein');
INSERT INTO Villain_FullName (name, fullname) VALUES ('H.N. Elly', 'The Box Witch');
INSERT INTO Villain_Alias (name, alias) VALUES ('H.N. Elly', 'H.N. Elly');
INSERT INTO Villain_Crime (name, crime) VALUES ('H.N. Elly', 'Driving people to suicide');
INSERT INTO Villain_Crime (name, crime) VALUES ('H.N. Elly', 'Torture');
INSERT INTO Evil_Doer (name) VALUES ('H.N. Elly');
INSERT INTO ED_Occupation (name, occupation) VALUES ('H.N. Elly', 'Witch');
INSERT INTO ED_Power (name, power) VALUES ('H.N. Elly', 'Marking Humans with her "kiss"');
INSERT INTO Villain (name, category) VALUES ('I (Shin Kamen Rider)', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('I (Shin Kamen Rider)', 'Artificial Intelligence');
INSERT INTO Villain_Origin (name, origin) VALUES ('I (Shin Kamen Rider)', 'Shin Kamen Rider');
INSERT INTO Villain_FullName (name, fullname) VALUES ('I (Shin Kamen Rider)', 'I');
INSERT INTO Villain_Alias (name, alias) VALUES ('I (Shin Kamen Rider)', 'The Great Leader');
INSERT INTO Villain_Crime (name, crime) VALUES ('I (Shin Kamen Rider)', 'Kidnapping');
INSERT INTO Villain_Crime (name, crime) VALUES ('I (Shin Kamen Rider)', 'Unethical experimentation');
INSERT INTO Villain_Goal (name, goal) VALUES ('I (Shin Kamen Rider)', 'Guide humanity to achieve "happiness" by any means.');
INSERT INTO Evil_Doer (name) VALUES ('I (Shin Kamen Rider)');
INSERT INTO ED_Occupation (name, occupation) VALUES ('I (Shin Kamen Rider)', 'Leader of Shocker');
INSERT INTO ED_Power (name, power) VALUES ('I (Shin Kamen Rider)', 'High intelligence');
INSERT INTO ED_Power (name, power) VALUES ('I (Shin Kamen Rider)', 'Vast computational capability');
INSERT INTO Villain (name, category) VALUES ('J. Geil', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('J. Geil', 'Sadistic Serial Killer');
INSERT INTO Villain_Origin (name, origin) VALUES ('J. Geil', 'JoJo''s Bizarre Adventure: Stardust Crusaders');
INSERT INTO Villain_FullName (name, fullname) VALUES ('J. Geil', 'John Geil');
INSERT INTO Villain_FullName (name, fullname) VALUES ('J. Geil', 'John Gail');
INSERT INTO Villain_FullName (name, fullname) VALUES ('J. Geil', 'John Guile');
INSERT INTO Villain_FullName (name, fullname) VALUES ('J. Geil', 'John Gale');
INSERT INTO Villain_Alias (name, alias) VALUES ('J. Geil', 'J. Geil');
INSERT INTO Villain_Alias (name, alias) VALUES ('J. Geil', 'J. Gail');
INSERT INTO Villain_Alias (name, alias) VALUES ('J. Geil', 'J. Guile');
INSERT INTO Villain_Alias (name, alias) VALUES ('J. Geil', 'J. Gale');
INSERT INTO Villain_Alias (name, alias) VALUES ('J. Geil', 'Centerfold');
INSERT INTO Villain_Alias (name, alias) VALUES ('J. Geil', 'The Double Right-Handed Man');
INSERT INTO Villain_Alias (name, alias) VALUES ('J. Geil', 'The Man With Two Right Hands');
INSERT INTO Villain_Alias (name, alias) VALUES ('J. Geil', 'Assassin Reflected in the Mirror');
INSERT INTO Villain_Crime (name, crime) VALUES ('J. Geil', 'Serial murder');
INSERT INTO Villain_Crime (name, crime) VALUES ('J. Geil', 'Serial rape');
INSERT INTO Villain_Crime (name, crime) VALUES ('J. Geil', 'Pedophilia');
INSERT INTO Villain_Crime (name, crime) VALUES ('J. Geil', 'Assault');
INSERT INTO Villain_Crime (name, crime) VALUES ('J. Geil', 'Attempted incrimination');
INSERT INTO Villain_Goal (name, goal) VALUES ('J. Geil', 'Rape as many women as he can .');
INSERT INTO Villain_Goal (name, goal) VALUES ('J. Geil', 'Kill Polnareff and the rest of the crusaders .');
INSERT INTO Evil_Doer (name) VALUES ('J. Geil');
INSERT INTO ED_Occupation (name, occupation) VALUES ('J. Geil', 'Serial killer');
INSERT INTO ED_Occupation (name, occupation) VALUES ('J. Geil', 'Mercenary');
INSERT INTO ED_Power (name, power) VALUES ('J. Geil', 'Hanged Man:');
INSERT INTO ED_Power (name, power) VALUES ('J. Geil', 'Attacking his enemies'' reflections');
INSERT INTO ED_Power (name, power) VALUES ('J. Geil', 'Invincibility while in a reflection');
INSERT INTO ED_Power (name, power) VALUES ('J. Geil', 'Knifesmanship');
INSERT INTO ED_Power (name, power) VALUES ('J. Geil', 'Luminal speed');
INSERT INTO Villain (name, category) VALUES ('K (Bloody Monday)', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('K (Bloody Monday)', 'Terrorist');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('K (Bloody Monday)', 'Dark Messiah');
INSERT INTO Villain_Origin (name, origin) VALUES ('K (Bloody Monday)', 'Bloody Monday (manga series)');
INSERT INTO Villain_FullName (name, fullname) VALUES ('K (Bloody Monday)', 'Anzai Mako');
INSERT INTO Villain_Alias (name, alias) VALUES ('K (Bloody Monday)', 'K');
INSERT INTO Villain_Alias (name, alias) VALUES ('K (Bloody Monday)', 'Anko');
INSERT INTO Villain_Alias (name, alias) VALUES ('K (Bloody Monday)', 'High Priest K');
INSERT INTO Villain_Goal (name, goal) VALUES ('K (Bloody Monday)', 'Break the cult leader Kamishima Shimon out of prison (stated)Take Shimon''s place as cult leader (succeeded)');
INSERT INTO Villain_Goal (name, goal) VALUES ('K (Bloody Monday)', 'Activate a neutron bomb killing everyone in Tokyo (failed)');
INSERT INTO Evil_Doer (name) VALUES ('K (Bloody Monday)');
INSERT INTO ED_Occupation (name, occupation) VALUES ('K (Bloody Monday)', 'newspaper club');
INSERT INTO ED_Occupation (name, occupation) VALUES ('K (Bloody Monday)', 'cult leader');
INSERT INTO ED_Power (name, power) VALUES ('K (Bloody Monday)', 'charisma');
INSERT INTO ED_Power (name, power) VALUES ('K (Bloody Monday)', 'deception');
INSERT INTO ED_Power (name, power) VALUES ('K (Bloody Monday)', 'technology');
INSERT INTO Villain (name, category) VALUES ('L''Arc Berg', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('L''Arc Berg', 'Tragic Extremist');
INSERT INTO Villain_Origin (name, origin) VALUES ('L''Arc Berg', 'The Rising of the Shield Hero');
INSERT INTO Villain_FullName (name, fullname) VALUES ('L''Arc Berg', 'L''Arc Berg Sickle');
INSERT INTO Villain_Alias (name, alias) VALUES ('L''Arc Berg', 'L''Arc');
INSERT INTO Villain_Alias (name, alias) VALUES ('L''Arc Berg', 'Boy');
INSERT INTO Villain_Alias (name, alias) VALUES ('L''Arc Berg', 'The Scythe Hero');
INSERT INTO Villain_Alias (name, alias) VALUES ('L''Arc Berg', 'Young Master');
INSERT INTO Villain_Crime (name, crime) VALUES ('L''Arc Berg', 'Attempted mass murder');
INSERT INTO Villain_Crime (name, crime) VALUES ('L''Arc Berg', 'Conspiracy');
INSERT INTO Villain_Goal (name, goal) VALUES ('L''Arc Berg', 'Kill Naofumi and his party and destroy their world to save his own .');
INSERT INTO Villain_Goal (name, goal) VALUES ('L''Arc Berg', 'Reunite with Kizuna.');
INSERT INTO Villain_Goal (name, goal) VALUES ('L''Arc Berg', 'Help Naofumi and the other cardinal heroes save the Eight Worlds .');
INSERT INTO Villain_Goal (name, goal) VALUES ('L''Arc Berg', 'Run and protect his country.');
INSERT INTO Villain_Goal (name, goal) VALUES ('L''Arc Berg', 'Be with Therese .');
INSERT INTO Evil_Doer (name) VALUES ('L''Arc Berg');
INSERT INTO ED_Occupation (name, occupation) VALUES ('L''Arc Berg', 'Hunting Hero');
INSERT INTO ED_Occupation (name, occupation) VALUES ('L''Arc Berg', 'King of an unnamed country');
INSERT INTO ED_Power (name, power) VALUES ('L''Arc Berg', 'Charisma');
INSERT INTO Villain (name, category) VALUES ('Maashiima', 'evil_doers');
INSERT INTO Evil_Doer (name) VALUES ('Maashiima');
INSERT INTO Villain (name, category) VALUES ('N (Pokemon)', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('N (Pokemon)', 'Honorable Freedom Fighter');
INSERT INTO Villain_Origin (name, origin) VALUES ('N (Pokemon)', 'Pokemon Black');
INSERT INTO Villain_Origin (name, origin) VALUES ('N (Pokemon)', 'Pokemon White');
INSERT INTO Villain_FullName (name, fullname) VALUES ('N (Pokemon)', 'Natural Harmonia Gropius');
INSERT INTO Villain_Alias (name, alias) VALUES ('N (Pokemon)', 'N');
INSERT INTO Villain_Alias (name, alias) VALUES ('N (Pokemon)', 'King N');
INSERT INTO Villain_Alias (name, alias) VALUES ('N (Pokemon)', 'Freak Without a Human Heart');
INSERT INTO Villain_Crime (name, crime) VALUES ('N (Pokemon)', 'Attempting to force everyone to release their Pokemon');
INSERT INTO Villain_Crime (name, crime) VALUES ('N (Pokemon)', 'Oppression');
INSERT INTO Villain_Crime (name, crime) VALUES ('N (Pokemon)', 'Conspiracy');
INSERT INTO Villain_Goal (name, goal) VALUES ('N (Pokemon)', 'Forever separate Pokemon and Humans from each other .');
INSERT INTO Villain_Goal (name, goal) VALUES ('N (Pokemon)', 'Help Nate and Ghetsis fight off Giovanni.');
INSERT INTO Villain_Goal (name, goal) VALUES ('N (Pokemon)', 'Assist in the defense of Pasio against Team Rocket .');
INSERT INTO Evil_Doer (name) VALUES ('N (Pokemon)');
INSERT INTO ED_Occupation (name, occupation) VALUES ('N (Pokemon)', 'Leader and false king of Team Plasma');
INSERT INTO ED_Occupation (name, occupation) VALUES ('N (Pokemon)', 'Wandering Pokemon trainer');
INSERT INTO ED_Power (name, power) VALUES ('N (Pokemon)', 'Pokemon training expertise');
INSERT INTO ED_Power (name, power) VALUES ('N (Pokemon)', 'Ability to communicate with other Pokemon');
INSERT INTO ED_Power (name, power) VALUES ('N (Pokemon)', 'Charisma');
INSERT INTO Villain (name, category) VALUES ('Obed Marsh', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('Obed Marsh', 'Greedy Dark Priest');
INSERT INTO Villain_Origin (name, origin) VALUES ('Obed Marsh', 'The Shadow Over Innsmouth');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Obed Marsh', 'Obed Marsh');
INSERT INTO Villain_Alias (name, alias) VALUES ('Obed Marsh', 'Captain Obed');
INSERT INTO Villain_Crime (name, crime) VALUES ('Obed Marsh', 'Human sacrifice');
INSERT INTO Villain_Crime (name, crime) VALUES ('Obed Marsh', 'Rape by proxy');
INSERT INTO Villain_Goal (name, goal) VALUES ('Obed Marsh', 'Continue profiting from sacrifice to the Deep Ones');
INSERT INTO Evil_Doer (name) VALUES ('Obed Marsh');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Obed Marsh', 'Captain');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Obed Marsh', 'Leader of the Esoteric Order of Dagon');
INSERT INTO ED_Power (name, power) VALUES ('Obed Marsh', 'Oratory');
INSERT INTO ED_Power (name, power) VALUES ('Obed Marsh', 'Knowledge of black rites');
INSERT INTO Villain (name, category) VALUES ('Page One', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('Page One', 'Sibling Pirate');
INSERT INTO Villain_Origin (name, origin) VALUES ('Page One', 'One Piece');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Page One', 'Page One');
INSERT INTO Villain_Alias (name, alias) VALUES ('Page One', 'Pay-Pay');
INSERT INTO Villain_Alias (name, alias) VALUES ('Page One', 'Page One-sama');
INSERT INTO Villain_Crime (name, crime) VALUES ('Page One', 'Piracy');
INSERT INTO Villain_Crime (name, crime) VALUES ('Page One', 'Attempted murders');
INSERT INTO Villain_Crime (name, crime) VALUES ('Page One', 'Mass property damage');
INSERT INTO Villain_Crime (name, crime) VALUES ('Page One', 'Animal cruelty');
INSERT INTO Villain_Crime (name, crime) VALUES ('Page One', 'Conspiracy');
INSERT INTO Villain_Goal (name, goal) VALUES ('Page One', 'Assist his crew.');
INSERT INTO Villain_Goal (name, goal) VALUES ('Page One', 'Kill Sanji and Usopp .');
INSERT INTO Villain_Goal (name, goal) VALUES ('Page One', 'Serving Yamato');
INSERT INTO Evil_Doer (name) VALUES ('Page One');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Page One', 'Pirate');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Page One', 'Shinuchi');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Page One', 'Member of the Beast Pirates');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Page One', 'Member of the Tobiroppo');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Page One', 'Yamato''s Follower');
INSERT INTO ED_Power (name, power) VALUES ('Page One', 'Haki User');
INSERT INTO ED_Power (name, power) VALUES ('Page One', 'Dragon-Dragon Fruit, Model: Spinosaurus');
INSERT INTO ED_Power (name, power) VALUES ('Page One', 'Ryu Ryu no Mi, Model: Spinosaurus');
INSERT INTO Villain (name, category) VALUES ('Ra-Dorudo-Gu', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('Ra-Dorudo-Gu', 'Right-Hand');
INSERT INTO Villain_Origin (name, origin) VALUES ('Ra-Dorudo-Gu', 'Kamen Rider Kuuga');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Ra-Dorudo-Gu', 'Ra-Dorudo-Gu');
INSERT INTO Villain_Alias (name, alias) VALUES ('Ra-Dorudo-Gu', 'Unidentified Life Form #8');
INSERT INTO Villain_Crime (name, crime) VALUES ('Ra-Dorudo-Gu', 'Instigating Mass Murder');
INSERT INTO Villain_Goal (name, goal) VALUES ('Ra-Dorudo-Gu', 'Ensure the commencement of the Gegeru.');
INSERT INTO Evil_Doer (name) VALUES ('Ra-Dorudo-Gu');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Ra-Dorudo-Gu', 'Member of the Ra Group of the Gurongi');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Ra-Dorudo-Gu', 'Judge of the Gurongi Game');
INSERT INTO Villain (name, category) VALUES ('S-Hawk', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('S-Hawk', 'Clone Swordsman');
INSERT INTO Villain_Origin (name, origin) VALUES ('S-Hawk', 'One Piece');
INSERT INTO Villain_FullName (name, fullname) VALUES ('S-Hawk', 'S-Hawk');
INSERT INTO Villain_Alias (name, alias) VALUES ('S-Hawk', 'Hawk-eyes');
INSERT INTO Villain_Crime (name, crime) VALUES ('S-Hawk', 'Assault');
INSERT INTO Villain_Crime (name, crime) VALUES ('S-Hawk', 'Attempted murder');
INSERT INTO Villain_Goal (name, goal) VALUES ('S-Hawk', 'Complete his mission as ordered by whoever orders him to complete it.');
INSERT INTO Evil_Doer (name) VALUES ('S-Hawk');
INSERT INTO ED_Occupation (name, occupation) VALUES ('S-Hawk', 'Seraphim');
INSERT INTO ED_Power (name, power) VALUES ('S-Hawk', 'Superhuman strength');
INSERT INTO ED_Power (name, power) VALUES ('S-Hawk', 'Superhuman speed');
INSERT INTO ED_Power (name, power) VALUES ('S-Hawk', 'Swordsmanship');
INSERT INTO ED_Power (name, power) VALUES ('S-Hawk', 'Shape-shifting');
INSERT INTO Villain (name, category) VALUES ('Tabitha (Pokemon)', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('Tabitha (Pokemon)', 'Enigmatic Right-Hand');
INSERT INTO Villain_Origin (name, origin) VALUES ('Tabitha (Pokemon)', 'Pokemon');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Tabitha (Pokemon)', 'Tabitha');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Tabitha (Pokemon)', 'Harlan');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Tabitha (Pokemon)', 'Homura');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Tabitha (Pokemon)', 'Kalle');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Tabitha (Pokemon)', 'Tatiano');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Tabitha (Pokemon)', 'Kelvin');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Tabitha (Pokemon)', 'Ottavio');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Tabitha (Pokemon)', 'Hogeol');
INSERT INTO Villain_Alias (name, alias) VALUES ('Tabitha (Pokemon)', 'Field Commander Harlan');
INSERT INTO Villain_Crime (name, crime) VALUES ('Tabitha (Pokemon)', 'Theft');
INSERT INTO Villain_Crime (name, crime) VALUES ('Tabitha (Pokemon)', 'Terrorism');
INSERT INTO Villain_Goal (name, goal) VALUES ('Tabitha (Pokemon)', 'Capturing Groudon in order to expand the lands.');
INSERT INTO Villain_Goal (name, goal) VALUES ('Tabitha (Pokemon)', 'Getting a promotion .');
INSERT INTO Villain_Goal (name, goal) VALUES ('Tabitha (Pokemon)', 'Protecting Pasio from Team Rocket .');
INSERT INTO Evil_Doer (name) VALUES ('Tabitha (Pokemon)');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Tabitha (Pokemon)', 'Admin of Team Magma');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Tabitha (Pokemon)', 'Scientist');
INSERT INTO ED_Power (name, power) VALUES ('Tabitha (Pokemon)', 'Training Pokemon');
INSERT INTO ED_Power (name, power) VALUES ('Tabitha (Pokemon)', 'Scientifical knowledge');
INSERT INTO Villain (name, category) VALUES ('Ubik', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('Ubik', 'Deal-Making Trickster');
INSERT INTO Villain_Origin (name, origin) VALUES ('Ubik', 'Berserk');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Ubik', 'Ubik');
INSERT INTO Villain_Crime (name, crime) VALUES ('Ubik', 'Psychological torture');
INSERT INTO Villain_Crime (name, crime) VALUES ('Ubik', 'Mass murder');
INSERT INTO Villain_Crime (name, crime) VALUES ('Ubik', 'Mass human sacrifice');
INSERT INTO Villain_Crime (name, crime) VALUES ('Ubik', 'Corruption');
INSERT INTO Villain_Crime (name, crime) VALUES ('Ubik', 'Terrorism');
INSERT INTO Villain_Goal (name, goal) VALUES ('Ubik', 'Serve The Idea of Evil and its purpose of giving reason for humanity''s suffering.');
INSERT INTO Villain_Goal (name, goal) VALUES ('Ubik', 'Maintain and enforce the Law of Causality.');
INSERT INTO Evil_Doer (name) VALUES ('Ubik');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Ubik', 'Member of the God Hand');
INSERT INTO ED_Power (name, power) VALUES ('Ubik', 'Reality warping');
INSERT INTO ED_Power (name, power) VALUES ('Ubik', 'Illusory powers');
INSERT INTO ED_Power (name, power) VALUES ('Ubik', 'Immortality');
INSERT INTO ED_Power (name, power) VALUES ('Ubik', 'Levitation');
INSERT INTO Villain (name, category) VALUES ('X (Dice)', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('X (Dice)', 'Tragic Cosmic Entity');
INSERT INTO Villain_Origin (name, origin) VALUES ('X (Dice)', 'DICE');
INSERT INTO Villain_Alias (name, alias) VALUES ('X (Dice)', 'X');
INSERT INTO Villain_Alias (name, alias) VALUES ('X (Dice)', 'Game Master');
INSERT INTO Villain_Crime (name, crime) VALUES ('X (Dice)', 'Harassing');
INSERT INTO Villain_Crime (name, crime) VALUES ('X (Dice)', 'Murder');
INSERT INTO Villain_Crime (name, crime) VALUES ('X (Dice)', 'Manipulating');
INSERT INTO Villain_Crime (name, crime) VALUES ('X (Dice)', 'Hacking');
INSERT INTO Villain_Crime (name, crime) VALUES ('X (Dice)', 'Putting individuals into his twisted games and observe to see the final results');
INSERT INTO Villain_Goal (name, goal) VALUES ('X (Dice)', 'Put as many as "DICERS" into chaotic situations to observe their reactions');
INSERT INTO Villain_Goal (name, goal) VALUES ('X (Dice)', 'Defeat the protagonist');
INSERT INTO Evil_Doer (name) VALUES ('X (Dice)');
INSERT INTO ED_Occupation (name, occupation) VALUES ('X (Dice)', 'Game master');
INSERT INTO ED_Power (name, power) VALUES ('X (Dice)', 'Auto-teleportation');
INSERT INTO ED_Power (name, power) VALUES ('X (Dice)', 'Time-stop');
INSERT INTO ED_Power (name, power) VALUES ('X (Dice)', 'Telekinesis');
INSERT INTO ED_Power (name, power) VALUES ('X (Dice)', 'Duplicating');
INSERT INTO ED_Power (name, power) VALUES ('X (Dice)', 'Pocket dimension creation');
INSERT INTO ED_Power (name, power) VALUES ('X (Dice)', 'Reality-warping');
INSERT INTO ED_Power (name, power) VALUES ('X (Dice)', 'Flying');
INSERT INTO ED_Power (name, power) VALUES ('X (Dice)', 'Wish granting');
INSERT INTO ED_Power (name, power) VALUES ('X (Dice)', 'High-intelligence');
INSERT INTO ED_Power (name, power) VALUES ('X (Dice)', 'Semi-omniscient');
INSERT INTO ED_Power (name, power) VALUES ('X (Dice)', 'Immortality');
INSERT INTO ED_Power (name, power) VALUES ('X (Dice)', 'Power bestowing');
INSERT INTO Villain (name, category) VALUES ('Yachiru Unohana', 'evil_doers');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('Yachiru Unohana', 'Redeemed Serial Killer');
INSERT INTO Villain_Origin (name, origin) VALUES ('Yachiru Unohana', 'Bleach');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Yachiru Unohana', 'Yachiru Unohana');
INSERT INTO Villain_Alias (name, alias) VALUES ('Yachiru Unohana', 'Retsu Unohana');
INSERT INTO Villain_Alias (name, alias) VALUES ('Yachiru Unohana', 'Captain Unohana');
INSERT INTO Villain_Alias (name, alias) VALUES ('Yachiru Unohana', 'The First Kenpachi');
INSERT INTO Villain_Alias (name, alias) VALUES ('Yachiru Unohana', 'Kenpachi Unohana');
INSERT INTO Villain_Alias (name, alias) VALUES ('Yachiru Unohana', 'Death Sword');
INSERT INTO Villain_Crime (name, crime) VALUES ('Yachiru Unohana', 'Serial murder');
INSERT INTO Villain_Goal (name, goal) VALUES ('Yachiru Unohana', 'Find someone that can rival her .');
INSERT INTO Villain_Goal (name, goal) VALUES ('Yachiru Unohana', 'Die at Kenpachi Zaraki''s hands for atone her "sin" and test his power progression .');
INSERT INTO Evil_Doer (name) VALUES ('Yachiru Unohana');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Yachiru Unohana', 'Criminal');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Yachiru Unohana', '1st Kenpachi/1st Captain of 11th division');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Yachiru Unohana', 'Captain of 4th division');
INSERT INTO ED_Occupation (name, occupation) VALUES ('Yachiru Unohana', 'President of Ikebana club');
INSERT INTO ED_Power (name, power) VALUES ('Yachiru Unohana', 'Master swordsmanship');
INSERT INTO ED_Power (name, power) VALUES ('Yachiru Unohana', 'Master healer');
INSERT INTO ED_Power (name, power) VALUES ('Yachiru Unohana', 'Master of Kido');
INSERT INTO ED_Power (name, power) VALUES ('Yachiru Unohana', 'Immense spiritual power');
INSERT INTO ED_Power (name, power) VALUES ('Yachiru Unohana', 'Wisdom');
INSERT INTO ED_Power (name, power) VALUES ('Yachiru Unohana', 'Charisma');
INSERT INTO Villain (name, category) VALUES ('Q (Jujutsu Kaisen)', 'evil_organizations');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('Q (Jujutsu Kaisen)', '??');
INSERT INTO Villain_Origin (name, origin) VALUES ('Q (Jujutsu Kaisen)', 'Jujutsu Kaisen');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Q (Jujutsu Kaisen)', 'Q');
INSERT INTO Villain_Crime (name, crime) VALUES ('Q (Jujutsu Kaisen)', 'Attempted murder');
INSERT INTO Villain_Crime (name, crime) VALUES ('Q (Jujutsu Kaisen)', 'Attempted world domination');
INSERT INTO Villain_Goal (name, goal) VALUES ('Q (Jujutsu Kaisen)', 'Prevent Tengen from ressetting their cursed techniques .');
INSERT INTO Evil_Organization (name, foundation) VALUES ('Q (Jujutsu Kaisen)', 'Sometime in 2006');
INSERT INTO EO_Agent (name, agent) VALUES ('Q (Jujutsu Kaisen)', 'BayerKokun');
INSERT INTO Villain (name, category) VALUES ('V (Tokyo Ghoul)', 'evil_organizations');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('V (Tokyo Ghoul)', 'Terrorist Organization');
INSERT INTO Villain_Origin (name, origin) VALUES ('V (Tokyo Ghoul)', 'Tokyo Ghoul');
INSERT INTO Villain_FullName (name, fullname) VALUES ('V (Tokyo Ghoul)', 'Vasuki');
INSERT INTO Villain_Alias (name, alias) VALUES ('V (Tokyo Ghoul)', 'V');
INSERT INTO Villain_Crime (name, crime) VALUES ('V (Tokyo Ghoul)', 'Genocide');
INSERT INTO Villain_Crime (name, crime) VALUES ('V (Tokyo Ghoul)', 'Mass murder');
INSERT INTO Villain_Crime (name, crime) VALUES ('V (Tokyo Ghoul)', 'Terrorism');
INSERT INTO Villain_Crime (name, crime) VALUES ('V (Tokyo Ghoul)', 'Espionage');
INSERT INTO Villain_Crime (name, crime) VALUES ('V (Tokyo Ghoul)', 'Conspiracy');
INSERT INTO Villain_Crime (name, crime) VALUES ('V (Tokyo Ghoul)', 'Hate crimes');
INSERT INTO Villain_Goal (name, goal) VALUES ('V (Tokyo Ghoul)', 'Destroy the Aogiri Tree and Eto to reduce competition .');
INSERT INTO Villain_Goal (name, goal) VALUES ('V (Tokyo Ghoul)', 'Maintain their "perfect balance" of the world.');
INSERT INTO Villain_Goal (name, goal) VALUES ('V (Tokyo Ghoul)', 'Eliminate Ken Kaneki .');
INSERT INTO Evil_Organization (name, foundation) VALUES ('V (Tokyo Ghoul)', NULL);
INSERT INTO EO_Agent (name, agent) VALUES ('V (Tokyo Ghoul)', 'Nimura Furuta');
INSERT INTO EO_Agent (name, agent) VALUES ('V (Tokyo Ghoul)', 'Kishou Arima');
INSERT INTO EO_Agent (name, agent) VALUES ('V (Tokyo Ghoul)', 'Kuzen');
INSERT INTO EO_Agent (name, agent) VALUES ('V (Tokyo Ghoul)', 'Rize Kamishiro');
INSERT INTO EO_Agent (name, agent) VALUES ('V (Tokyo Ghoul)', 'Various V members');
INSERT INTO EO_Commander (name, commander) VALUES ('V (Tokyo Ghoul)', 'Kaiko');
INSERT INTO EO_Commander (name, commander) VALUES ('V (Tokyo Ghoul)', 'Unknown V Leaders');
INSERT INTO EO_Headquarter (name, headquarter) VALUES ('V (Tokyo Ghoul)', 'Japan');
INSERT INTO EO_Power (name, power) VALUES ('V (Tokyo Ghoul)', 'Kagunes');
INSERT INTO EO_Power (name, power) VALUES ('V (Tokyo Ghoul)', 'Various superhuman abilities');
INSERT INTO EO_Power (name, power) VALUES ('V (Tokyo Ghoul)', 'Infiltration');
INSERT INTO EO_Power (name, power) VALUES ('V (Tokyo Ghoul)', 'Connections to the CCG');
INSERT INTO Villain (name, category) VALUES ('Zabi Family', 'evil_families');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('Zabi Family', 'Totalitarian Aristocrats');
INSERT INTO Villain_Origin (name, origin) VALUES ('Zabi Family', 'Mobile Suit Gundam');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Zabi Family', 'Zabi Family');
INSERT INTO Villain_Alias (name, alias) VALUES ('Zabi Family', 'Zabi Family Dictatorship');
INSERT INTO Villain_Crime (name, crime) VALUES ('Zabi Family', 'Murder');
INSERT INTO Villain_Crime (name, crime) VALUES ('Zabi Family', 'Corruption');
INSERT INTO Villain_Crime (name, crime) VALUES ('Zabi Family', 'Conspiracy');
INSERT INTO Villain_Crime (name, crime) VALUES ('Zabi Family', 'Genocide');
INSERT INTO Villain_Crime (name, crime) VALUES ('Zabi Family', 'Abuse of power');
INSERT INTO Villain_Crime (name, crime) VALUES ('Zabi Family', 'War crimes');
INSERT INTO Villain_Goal (name, goal) VALUES ('Zabi Family', 'Conquer the Earth Sphere.');
INSERT INTO Evil_Family (name, home_base_of_operations, patriarch, matriarch) VALUES (
        'Zabi Family',
        'Principality of Zeon',
        'Degwin Sodo Zabi',
        'Naliss Zabi'
      );
INSERT INTO EF_Member (name, member) VALUES ('Zabi Family', 'Gihren Zabi');
INSERT INTO EF_Member (name, member) VALUES ('Zabi Family', 'Sasro Zabi');
INSERT INTO EF_Member (name, member) VALUES ('Zabi Family', 'Kycilia Zabi');
INSERT INTO EF_Member (name, member) VALUES ('Zabi Family', 'Dozle Zabi');
INSERT INTO EF_Member (name, member) VALUES ('Zabi Family', 'Garma Zabi');
INSERT INTO EF_Member (name, member) VALUES ('Zabi Family', 'Zenna Zabi');
INSERT INTO EF_Member (name, member) VALUES ('Zabi Family', 'Mineva Lao Zabi');
INSERT INTO Villain (name, category) VALUES ('Waddle Dees', 'hostile_species');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('Waddle Dees', 'On &amp');
INSERT INTO Villain_Type (name, type_of_villain) VALUES ('Waddle Dees', 'Off Minions');
INSERT INTO Villain_Origin (name, origin) VALUES ('Waddle Dees', 'Kirby''s Dream Land');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Waddle Dees', 'Waddle Dees');
INSERT INTO Villain_FullName (name, fullname) VALUES ('Waddle Dees', 'Wadorudis');
INSERT INTO Villain_Crime (name, crime) VALUES ('Waddle Dees', 'Terrorism');
INSERT INTO Villain_Crime (name, crime) VALUES ('Waddle Dees', 'Attempted murder');
INSERT INTO Villain_Crime (name, crime) VALUES ('Waddle Dees', 'Kidnapping');
INSERT INTO Villain_Crime (name, crime) VALUES ('Waddle Dees', 'Stalking');
INSERT INTO Villain_Crime (name, crime) VALUES ('Waddle Dees', 'Assault');
INSERT INTO Villain_Crime (name, crime) VALUES ('Waddle Dees', 'Treason');
INSERT INTO Villain_Crime (name, crime) VALUES ('Waddle Dees', 'Theft');
INSERT INTO Villain_Crime (name, crime) VALUES ('Waddle Dees', 'Aiding and abetting');
INSERT INTO Villain_Goal (name, goal) VALUES ('Waddle Dees', 'Help Dedede in his villainous plans.');
INSERT INTO Hostile_Species (name, homeworld) VALUES ('Waddle Dees', 'Planet Popstar');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Variants:');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Armor Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Armor Halcandra Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Balloon Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Big Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Block Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Bow Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Cart Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Cyborg Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Fluff Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Grand Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Gold Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Halcandra Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Hardhat Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Kee Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Lumberjack Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Missile Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Painted Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Parasol Cyborg Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Parasol Halcandra Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Parasol Hardhat Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Parasol Sectra Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Parasol Spear Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Propeller Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Purple Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Purple Spear Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Rolling Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Sectra Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Snowball Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Soldier Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Spear Sectra Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Spear Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Swinging Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Truck Monsters');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Waddle Dee Drivers');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Waddle Dee Trains');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Walker Waddle Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Wapods');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Individuals:');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Arena Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Bandana Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Block Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Cafe-Manager Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Cafe-Staff Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Channel PPP Crew');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Reporter Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Camera Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Microphone Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Assistant Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Colossal Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Colossal Spear Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Commentator Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Delivery Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Game-Shop Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Item-Shop Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Minion Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Sailor Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Sectra Dee Steel Fortress');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'The Deedly Dees');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Toughness Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Trader Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Usher Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Waddle Dee portrait');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Waddle Dee Steel Fortress');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Waddle Tank');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Weapons-Shop Waddle Dee');
INSERT INTO HS_Member (name, relative_member) VALUES ('Waddle Dees', 'Wise Waddle Dee');
INSERT INTO HS_Abilities (name, ability) VALUES ('Waddle Dees', 'Skilled use of weapons');
INSERT INTO HS_Abilities (name, ability) VALUES ('Waddle Dees', 'Alexiliokinesis');
INSERT INTO HS_Abilities (name, ability) VALUES ('Waddle Dees', 'Damage upon contact');

COMMIT;
