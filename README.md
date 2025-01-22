# cardtrading

### Installation

1. Build and run the project

    ```bash
    docker compose up -d --build
    ```

2. Initialize the database:

    ```bash
    docker compose exec app bundle exec rails db:drop db:setup
    ```

### Usage
1. Public: [localhost:3100](http://localhost:3100)
2. Admin: [localhost:3100/admin](http://localhost:3100/admin)
