CREATE TABLE food (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    timestamp TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE UNIQUE INDEX food_idx_id ON food (id);

CREATE TABLE category (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    timestamp TEXT NOT NULL,
    name TEXT NOT NULL
);

CREATE TABLE food_to_category (
    food_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    FOREIGN KEY (food_id) REFERENCES food(id),
    FOREIGN KEY (category_id) REFERENCES category(id)
);

CREATE UNIQUE INDEX food_to_category_idx_food_id ON food_to_category (food_id);
CREATE UNIQUE INDEX food_to_category_idx_category_id ON food_to_category (category_id);

CREATE TABLE category_to_parent (
    parent_id INTEGER NOT NULL,
    child_id INTEGER NOT NULL,
    FOREIGN KEY (parent_id) REFERENCES category(id),
    FOREIGN KEY (child_id) REFERENCES category(id)
);

CREATE TABLE nutrient (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    timestamp TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT
);

-- Dietary Reference Intakes (DRIs) name refers to the DRI group (infants, children, males, females, pregnancy, lactation of various ages)
CREATE TABLE dri (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    timestamp TEXT NOT NULL,
    group_name TEXT NOT NULL,
    nutrient_id INTEGER NOT NULL,
    FOREIGN KEY (nutrient_id) REFERENCES nutrient(id)
);

--if quantity 0 than take it as unknown
CREATE TABLE food_to_nutrient (
    food_id INTEGER NOT NULL,
    nutrient_id INTEGER NOT NULL,
    quantity REAL,
    quantity_estimated REAL,
    FOREIGN KEY (food_id) REFERENCES food(id),
    FOREIGN KEY (nutrient_id) REFERENCES nutrient(id)
);

CREATE INDEX food_to_nutrient_idx_food_id ON food_to_nutrient (food_id);
CREATE INDEX food_to_nutrient_idx_nutrient_id ON food_to_nutrient (nutrient_id);
CREATE INDEX food_to_nutrient_idx_quantity ON food_to_nutrient (quantity);

CREATE TABLE price (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    timestamp TEXT NOT NULL,
    price REAL NOT NULL
    
);

CREATE INDEX price_idx_price ON price (price);

CREATE TABLE food_to_price (
    food_id INTEGER,
    price_id INTEGER,
    FOREIGN KEY (food_id) REFERENCES food(id),
    FOREIGN KEY (price_id) REFERENCES price(id)
);

CREATE INDEX food_to_price_idx_food_id ON food_to_price (food_id);
CREATE UNIQUE INDEX food_to_price_idx_price_id ON food_to_price (price_id);

CREATE TABLE combo (
    id INTEGER PRIMARY KEY NOT NULL,
    timestamp TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE INDEX combo_idx_timestamp ON combo (timestamp);
CREATE INDEX combo_idx_name ON combo (name);

--if quantity 0, than take it as unknown
CREATE TABLE combo_to_food (
    combo_id INTEGER NOT NULL,
    food_id INTEGER NOT NULL,
    quantity INTEGER,
    FOREIGN KEY (combo_id) REFERENCES combo(id),
    FOREIGN KEY (food_id) REFERENCES food(id)
);

CREATE TABLE meal (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    timestamp TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE meal_to_food (
    meal_id INTEGER NOT NULL,
    food_id INTEGER NOT NULL,
    quantity_grams REAL NOT NULL,
    FOREIGN KEY (meal_id) REFERENCES meal(id),
    FOREIGN KEY (food_id) REFERENCES food(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    weight real NOT NULL,
    height real NOT NULL,
    gender TEXT NOT NULL,
    age INTEGER NOT NULL
);