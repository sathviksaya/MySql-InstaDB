create table users (id int auto_increment primary key, 
					username varchar(50) not NULL unique, 
					created_at timestamp default now()
				   );

create table photos (id int auto_increment primary key, 
					 image_url varchar(50) not NULL, 
					 user_id int not NULL,
					 caption varchar(255),
					 posted_at timestamp default now(), 
					 foreign key(user_id) references users(id)
					);

create table comments (id int auto_increment primary key, 
					   comment_text varchar(255) not NULL, 
					   user_id int not NULL, 
					   photo_id int not NULL, 
					   commented_at timestamp default now(), 
					   foreign key(user_id) references users(id), 
					   foreign key(photo_id) references photos(id)
					  );

create table likes (user_id int not NULL, 
					photo_id int not NULL, 
					liked_at timestamp default now(), 
					foreign key(user_id) references users(id), 
					foreign key(photo_id) references photos(id), 
					primary key(user_id, photo_id)
				   );

create table follows (follower_id int not NULL,
					  following_id int not NULL,
					  followed_at timestamp default now(),
					  foreign key(follower_id) references users(id),
					  foreign key(following_id) references users(id),
					  primary key(follower_id, following_id)
					 );

create table unfollows (follower_id int not NULL,
					  following_id int not NULL,
					  unfollowed_at timestamp default now(),
					  foreign key(follower_id) references users(id),
					  foreign key(following_id) references users(id),
					  primary key(follower_id, following_id)
					 );

create table tags (id int auto_increment primary key,
				   tag_name varchar(100) unique,
				   tagged_at timestamp default now()
				  );

create table photo_tags (tag_id int not NULL, 
						 photo_id int not NULL,
						 foreign key(tag_id) references tags(id),
						 foreign key(photo_id) references photos(id),
						 primary key(photo_id, tag_id)
						);