# README

## Registration code endpoints:

### To generate a new code

- **Endpoint:** `POST http://localhost:3000/api/v1/generate_code`
- **Request Body:**
  - Example:
    ```
    {
      "email": "example@email.com"
    }
    ```

### To get all codes

- **Endpoint:** `GET http://localhost:3000/api/v1/codes`
