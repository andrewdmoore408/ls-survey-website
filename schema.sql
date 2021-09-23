CREATE TABLE surveys(
   id serial PRIMARY KEY,
   name text NOT NULL
 );
                                                        
 CREATE TABLE questions(
  id serial PRIMARY KEY,
  survey_id int REFERENCES surveys(id) ON DELETE CASCADE NOT NULL,
  text text NOT NULL
);

 CREATE TABLE contributors(
   id serial PRIMARY KEY,
   email_address text UNIQUE NOT NULL
 );

 CREATE TABLE responses(
   id serial PRIMARY KEY,
   question_id int REFERENCES questions(id) NOT NULL,
   contributor_id int REFERENCES contributors(id) NOT NULL,
   text text NOT NULL,
   submitted_on timestamp DEFAULT NOW()
 );
