## Find all recipes with less than 500 calories.
SELECT r.name, n.name, rn.value
FROM recipe r JOIN recipe_nutrition rn ON r.id = rn.id
			  JOIN nutrition n ON rn.nutrition_id = n.nutrition_id
WHERE n.name LIKE 'calories' AND rn.value < 500


## Find all gluten free recipes!
SELECT r.name, t.name
FROM recipe r JOIN recipe_tags rt ON r.id = rt.id
			  JOIN tag t ON rt.tag_id = t.tag_id
WHERE t.name LIKE 'gluten-free'


## Find all top rated recipes, their reviews and submitions date.
SELECT r.name, i.rating, i.review, i.submitted
FROM recipe r JOIN interacts i ON r.id = i.id
WHERE i.rating > 4


## Stored procedures to get recipes with variable ingredient names.
DELIMITER //
CREATE PROCEDURE getRecipesWith (IN ingredient nvarchar(30))
BEGIN
	SELECT DISTINCT r.name, i.raw_ingredient, r.description
	FROM recipe r JOIN recipe_ingredient ri ON r.id = ri.id
				  JOIN ingredient i ON ri.ingredient_id = i.ingredient_id
                  JOIN interacts ON r.id = interacts.id
	WHERE i.raw_ingredient = ingredient AND interacts.rating > 3;
END //
DELIMITER ;
CALL getRecipesWith('onion');


## Find recipes with ther tag Italian.
SELECT r.id, r.name, r.minutes, r.n_steps, r.steps, r.description, t.name
FROM recipe r JOIN recipe_tags rt ON r.id = rt.id
              JOIN tag t ON rt.tag_id = t.tag_id
WHERE t.name LIKE 'Italian'
LIMIT 100;

# Find the average amount of reviews and rating of users
SELECT avg(u.n_ratings) AS Average_Number_Reviews, avg(i.rating)
FROM user u LEFT JOIN interacts i ON u.user_id = i.user_id;

#Find the recipes with the lowest rating
SELECT r.name, i.rating, i.review
FROM recipe r JOIN interacts i ON r.id = i.id
ORDER BY i.rating ASC
LIMIT 1000


