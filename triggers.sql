DELIMITER $$
	CREATE TRIGGER useless_update
	BEFORE UPDATE ON users FOR EACH ROW
	BEGIN
		IF OLD.username = NEW.username 
		THEN
			SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT = "Username is same as old one.";
		END IF;
	END;
	$$	
DELIMITER;

DELIMITER $$
	CREATE TRIGGER prevent_self_follows
	BEFORE INSERT ON follows FOR EACH ROW
	BEGIN
		IF NEW.follower_id = NEW.following_id 
		THEN
			SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT = "You cannot follow yourself.";
		END IF;
	END;
	$$
DELIMITER;

DELIMITER $$
	CREATE TRIGGER capture_unfollow
	After DELETE ON follows FOR EACH ROW
	BEGIN
		INSERT INTO unfollows(follower_id, following_id)
        values (OLD.follower_id, OLD.following_id);
	END;
	$$
DELIMITER;

SHOW TRIGGERS;

INSERT INTO follows(follower_id, following_id) VALUES (1, 1);

DELETE FROM follows where follower_id = 2 AND following_id = 1;
SELECT * FROM unfollows;

UPDATE users set username = 'Gus93' where username = 'Gus93';