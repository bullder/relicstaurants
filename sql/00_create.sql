CREATE USER new WITH PASSWORD 'new';
CREATE DATABASE new OWNER new;
GRANT ALL PRIVILEGES ON DATABASE new TO new;

USE new;

CREATE TABLE restaurants (
     id VARCHAR(255) PRIMARY KEY,
     name VARCHAR(255) NOT NULL,
     cuisine VARCHAR(100),
     opens TIME,
     closes TIME,
     days INT[] NOT NULL,
     price INT CHECK (price >= 0),
     rating INT CHECK (rating >= 0 AND rating <= 5),
     location VARCHAR(255),
     description TEXT
);

INSERT INTO restaurants (id, name, cuisine, opens, closes, days, price, rating, location, description)
VALUES
    ('esthers', 'Esther''s German Saloon', 'german', '11:30:00', '22:30:00', '{1,2,3,4,5,6}', 3, 3, '22 Teutonic Ave.', 'German home-cooked meals and fifty-eight different beers on tap. To get more authentic, you''d need to be wearing lederhosen.'),
    ('robatayaki', 'Robatayaki Hachi', 'japanese', '17:30:00', '23:30:00', '{0,1,2,3,4,5,6}', 4, 5, '8 Hawthorne Ln.', 'Japanese food the way you like it. Fast, fresh, grilled.'),
    ('tofuparadise', 'BBQ Tofu Paradise', 'vegetarian', '16:30:00', '20:00:00', '{0,2,4,5,6}', 2, 1, '22A King West', 'Vegetarians, we have your BBQ needs covered. Our home-made tofu skewers and secret BBQ sauce will have you licking your fingers.'),
    ('bateaurouge', 'Le Bateau Rouge', 'french', '17:00:00', '23:30:00', '{0,1,2,3,4,5,6}', 5, 4, '2 South Park Dr.', 'Fine French dining in a romantic setting. From soupe à l''oignon to coq au vin, let our chef delight you with a local take on authentic favorites.'),
    ('khartoum', 'Khartoum Khartoum', 'african', '11:00:00', '14:00:00', '{1,2,3,4,5}', 3, 2, '1566 Maple Rd.', 'African homestyle cuisine, cooked fresh daily.'),
    ('sallys', 'Sally''s Diner', 'american', '08:30:00', '20:00:00', '{0,1,2,3,4,5,6}', 4, 3, '96 College Blvd.', 'Food like mom cooked, if you grew up in Iowa and mom ran a diner. Try our blue plate special!'),
    ('saucy', 'Saucy Piggy', 'barbecue', '15:00:00', '22:00:00', '{1,2,3,4,5,6}', 3, 2, '623 Industrial Rd.', 'Pork. We know how to cook it. Award-winning BBQ sauce, and meat with all the trimmings.'),
    ('czechpoint', 'Czech Point', 'czech/slovak', '10:30:00', '21:30:00', '{1,2,3,4,5,6}', 1, 4, '5567 Queen-Mary Rd', 'Make a point of trying our knedlíky and homemade soups. We have free wifi and the best desserts and coffee.'),
    ('speisewagen', 'Der Speisewagen', 'german', '17:00:00', '22:30:00', '{0,1,2,3,4,5,6}', 3, 5, '402 College Blvd.', 'Award-winning schnitzel and other favorites. Look for our restored food truck in the NE corner of the College St lot.'),
    ('beijing', 'Beijing Express', 'chinese', '11:00:00', '22:30:00', '{0,2,4,5,6}', 2, 4, '38 Teutonic Ave.', 'Fast, healthy, Chinese food. Family specials for takeout or delivery. Try our Peking Duck!'),
    ('satay', 'Satay Village', 'thai', '17:30:00', '22:00:00', '{0,1,2,3,4,5,6}', 4, 2, '12 High St.', 'Fine dining Thai-style. Wide selection of vegetarian entrées. We also deliver.'),
    ('cancun', 'Cancun', 'mexican', '11:30:00', '23:00:00', '{1,2,3,4,5}', 3, 3, '2030 Maple Rd.', 'Tacos, tortas, burritos, just the way you like them. Our hot sauce and guacamole are the best in town.'),
    ('curryup', 'Curry Up', 'indian', '17:00:00', '22:00:00', '{0,1,2,3,4,5,6}', 4, 5, '455 University', 'Indian food with a modern twist. We use all-natural ingredients and the finest spices to delight and tempt your palate.'),
    ('carthage', 'Carthage', 'african', '17:00:00', '22:30:00', '{1,2,3,4,5,6}', 2, 1, '59 Court Terrace', 'Wholesome food and all the rich flavor of Africa. Try our famous lentil soup.'),
    ('burgerama', 'Burgerama', 'american', '11:00:00', '23:00:00', '{1,2,3,4,5,6}', 5, 4, '456 University', 'Grade A beef, freshly ground every day, hand-cut fries, and home-made milkshakes. We make the best burgers in town. '),
    ('littlepigs', 'Three Little Pigs', 'barbecue', '11:30:00', '22:30:00', '{0,1,2,3,4,5,6}', 3, 2, '12 Summer Court', 'Genuine East Texas barbecue. Accept no substitutes!'),
    ('littleprague', 'Little Prague', 'czech/slovak', '11:00:00', '22:00:00', '{0,2,4,5,6}', 4, 3, '44 Park Ave', 'We''re famous for our housemade sausage and desserts. Come taste real European cooking.'),
    ('kohlhaus', 'Kohl Haus', 'german', '17:00:00', '22:30:00', '{0,1,2,3,4,5,6}', 3, 2, '3421 Queen-Mary Rd', 'East German specialties, in a family-friendly setting. Come warm up with our delicious soups.'),
    ('dragon', 'Dragon''s Tail', 'chinese', '17:00:00', '02:00:00', '{1,2,3,4,5}', 1, 4, '8 Jasmine Rd.', 'Take-out or dine-in Chinese food. Open late. Delivery available'),
    ('babythai', 'Hit Me Baby One More Thai', 'thai', '15:00:00', '22:00:00', '{0,1,2,3,4,5,6}', 3, 5, '12 Jasmine Rd.', 'Thai food with a youthful bar scene. Try our tropical inspired cocktails, or tuck into a plate of our famous pad thai.');