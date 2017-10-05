CREATE TABLE users (     
  id SERIAL4 PRIMARY KEY,
  user_name VARCHAR(100),
  email VARCHAR(200),
  password VARCHAR(50),
  password_digest VARCHAR(400)
);

CREATE TABLE meals (     
  id SERIAL4 PRIMARY KEY,
  meal_name VARCHAR(300),
  ingredients VARCHAR(500),
  instructions VARCHAR(1000),
  image_url VARCHAR(500),
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

  
ALTER TABLE meals ADD COLUMN user_id VARCHAR(,
FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE restrict,