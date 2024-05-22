# Client Search CLI

This is a minimalist command-line application written in Ruby for searching through a JSON dataset of clients. The application provides two main functionalities:
1. Search for clients by a partial match of their full name.
2. Find and display clients with duplicate email addresses.

## Usage
1. Searching: ruby client_search.rb -f clients.json -s "John"
2. Finding Duplicates: ruby client_search.rb -f clients.json -d

### JSON File Format

The JSON file should contain an array of client objects with the following structure:

```json
[
    {"id": 1, "full_name": "John Doe", "email": "john.doe@gmail.com"},
    {"id": 2, "full_name": "Jane Smith", "email": "jane.smith@gmail.com"},
    {"id": 3, "full_name": "Johnathan Doe", "email": "john.doe@gmail.com"}
]
