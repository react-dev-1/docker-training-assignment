for db tabe creation

docker compose up -d db
docker compose exec db psql -U user -d mydb -f /docker-entrypoint-initdb.d/init.sql 

Check whether the workbook is still in the container:

docker compose exec backend ls -lh /app/output


To keep future output on your computer, add this under the backend service in docker-compose.yml:

    volumes:
      - ./output:/app/output


Then rerun the scraper. To load existing Excel data into PostgreSQL, save the workbook as CSV and import it; it won’t be added to the table automatically.