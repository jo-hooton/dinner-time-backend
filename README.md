# Dinner Time Backend

## Overview

The backend of Dinner Time is developed using **Ruby on Rails** with **PostgreSQL** for the database. It manages recipe data, handles search queries, and supports filtering by ingredients, excluding ingredients, time constraints, and pagination.

## Features

- **PgSearch Integration**: Supports full-text search based on ingredients.
- **Ingredient Exclusion**: Backend logic to filter out recipes containing specific ingredients.
- **Filter by Cooking Time**: Users can filter recipes by preparation and cook time.
- **Pagination**: Supports infinite scroll by allowing paginated requests.
- **API for Frontend**: Provides endpoints to serve data to the frontend application.

## Installation

To run the backend locally:

1. Clone the repository.
2. Install dependencies: `bundle install`
3. Set up the database:
   - Create the database: `rails db:create`
   - Migrate the database: `rails db:migrate`
   - Seed the database with recipe data: `rails db:seed`
4. Start the backend server: `rails server`

## Endpoints

- **GET /recipes**: Fetch recipes based on search criteria, including ingredients, exclude filters, time constraints, and pagination parameters.

## Technologies Used

- **Ruby on Rails**
- **PostgreSQL** for database management
- **PgSearch** for efficient search functionality

## Future Improvements

- **Add User Authentication**: Implement user accounts for saving recipes and tracking favourites.
