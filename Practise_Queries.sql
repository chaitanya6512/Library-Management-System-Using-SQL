-- Project Task

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher) 
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

-- Print newly insert values in the books table.
SELECT * FROM books;

-- Task 2: Update an Existing Member's Address
UPDATE members
SET member_address = '123 Main St'
WHERE member_id = 'C101';

-- Print updated value in the members table
SELECT * FROM members;


-- -- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
SELECT * FROM issued_status
WHERE issued_id='IS121';

DELETE FROM issued_status
WHERE issued_id='IS121';

-- Print / checked the value be delete or not
SELECT * FROM issued_status
WHERE issued_id = 'IS121';



-- Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT * FROM issued_status
WHERE  issued_emp_id ='E101' ;


-- Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT  issued_emp_id,emp_name FROM issued_status 
JOIN employees ON emp_id = issued_emp_id
GROUP BY 1,2 
HAVING COUNT(issued_id)>1;


-- CTAS
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
CREATE TABLE book_cnts AS 
SELECT isbn,book_title FROM issued_status 
JOIN books ON issued_book_isbn = isbn
GROUP BY 1,2

-- Print new created table
SELECT * FROM book_cnts;


-- - Task 7. Retrieve All Books in a Specific Category:
SELECT * FROM books 
WHERE category = 'Classic';

-- Task 8: Find Total Rental Income by Category:
SELECT category, SUM(rental_price),COUNT(*)
FROM books JOIN issued_status ON issued_book_isbn=isbn
GROUP BY 1;

-- List Members Who Registered in the Last 180 Days:
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days'

INSERT INTO members(member_id, member_name, member_address, reg_date)
VALUES
('C118', 'sam', '145 Main St', '2024-06-01'),
('C119', 'john', '133 Main St', '2024-05-01');


-- task 10 List Employees with Their Branch Manager's Name and their branch details:
SELECT 
    e1.*,
    b.manager_id,
    e2.emp_name as manager
FROM employees as e1
JOIN  
branch as b
ON b.branch_id = e1.branch_id
JOIN
employees as e2
ON b.manager_id = e2.emp_id ; 


---- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:
CREATE TABLE boks_grter_sevn
AS
SELECT * FROM books
WHERE rental_price >7;

--Print newly created table
SELECT * FROM boks_grter_sevn;


-- Task 12: Retrieve the List of Books Not Yet Returned
SELECT DISTINCT issued_book_name FROM issued_status AS ist
LEFT JOIN return_status AS rst ON rst.issued_id = ist.issued_id 
WHERE return_id IS NULL


