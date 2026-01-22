# Get passwords
ROOT_PASS=$(cat secrets/db_root_password.txt)
WP_PASS=$(cat secrets/db_password.txt)

# 1. Check what exists right now
echo "=== Current databases ==="
docker exec mariadb mysql -u root -p"$ROOT_PASS" -e "SHOW DATABASES;"

echo "=== Current users ==="
docker exec mariadb mysql -u root -p"$ROOT_PASS" -e "SELECT User, Host FROM mysql.user;"

# 2. Create the missing WordPress database and user
echo "=== Creating WordPress database and user ==="
docker exec mariadb mysql -u root -p"$ROOT_PASS" <<SQL
CREATE DATABASE IF NOT EXISTS \`wordpress\`;
-- Remove existing user if any and recreate with correct password
DROP USER IF EXISTS 'wordpress_user'@'%';
CREATE USER 'wordpress_user'@'%' IDENTIFIED BY '$WP_PASS';
GRANT ALL PRIVILEGES ON \`wordpress\`.* TO 'wordpress_user'@'%';
FLUSH PRIVILEGES;
SQL

# 3. Verify creation
echo "=== Verification ==="
docker exec mariadb mysql -u root -p"$ROOT_PASS" -e "SHOW GRANTS FOR 'wordpress_user'@'%';"
