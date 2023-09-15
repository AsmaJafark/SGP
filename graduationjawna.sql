CREATE TABLE `id21212738_anasdatabase`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL UNIQUE,
  `name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `place` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
);
-------------------------------------------------
-------------------------------------------------
CREATE TABLE `id21212738_anasdatabase`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `marketName` VARCHAR(45) NOT NULL UNIQUE,
  `productName` VARCHAR(45) NOT NULL,
  `price` VARCHAR(45) NOT NULL,
  `manufacturing` VARCHAR(45) NOT NULL,
  `image` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
);
-------------------------------------------------
-------------------------------------------------
CREATE TABLE `id21212738_anasdatabase`.`cart` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  INDEX `product_id_idx` (`product_id` ASC),
  INDEX `user_id_idx` (`user_id` ASC),
  PRIMARY KEY (`id`),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE on update no action,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE on update no action
);