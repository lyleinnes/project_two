CREATE TABLE users (     
  id SERIAL4 PRIMARY KEY,
  user_name VARCHAR(300),
  email VARCHAR(500),
  password_digest VARCHAR(1000)
);

CREATE TABLE meals (     
  id SERIAL4 PRIMARY KEY,
  meal_name VARCHAR(500),
  image_url VARCHAR(1500),
  ingredients VARCHAR(1500),
  instructions VARCHAR(4000),
  created_at TIMESTAMP,
  user_id INTEGER,
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE restrict
);

CREATE TABLE likes (     
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE restrict,
  meal_id INTEGER,
  FOREIGN KEY (meal_id) REFERENCES meals (id) ON DELETE restrict
);

-- ^^ this is sql code ^^
-- serial4(5/6/7) allows 4(5/6/7) characters
-- capitals are sql keywords


-- below are just for reference --

INSERT INTO [table name] [column] VALUES [column value];

ALTER TABLE [table name] ADD COLUMN [column name] [column type];

ALTER TABLE meals drop COLUMN ingredients;

ALTER TABLE meals ADD COLUMN ingredients VARCHAR(2000);
  
ALTER TABLE meals ADD COLUMN user_id VARCHAR(,
FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE restrict,