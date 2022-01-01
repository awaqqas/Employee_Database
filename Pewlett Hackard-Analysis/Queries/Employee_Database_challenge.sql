SELECT emp_no, last_name, first_name
FROM employees as e

SELECT title, from_date, to_date
FROM titles as t

SELECT e.emp_no,
       e.first_name,
       e.last_name,
	   e.birth_date,
       t.title,
       t.from_date,
       t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
order by e.emp_no;

SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
WHERE (to_date='9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

SELECT COUNT(ut.emp_no), ut.title
--INTO retiring_titles
FROM unique_titles as ut
GROUP BY title 
ORDER BY COUNT(title) DESC;

SELECT DISTINCT ON(e.emp_no) e.emp_no, 
    e.first_name, 
    e.last_name, 
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibilty
FROM employees as e
Left outer Join dept_emp as de
ON (e.emp_no = de.emp_no)
Left outer Join titles as t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date='9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

SELECT COUNT(me.emp_no) AS Total, me.title
INTO mentoring_titles
FROM mentorship_eligibilty as me
GROUP BY title 
ORDER BY COUNT(title) DESC;

SELECT COUNT(ut.emp_no) AS Total, ut.title
INTO retiring_titles1
FROM unique_titles as ut
GROUP BY title 
ORDER BY COUNT(title) DESC;

SELECT SUM(rt.total) AS Overall
FROM retiring_titles1 as rt

SELECT SUM(mt.total) AS Overall
FROM mentoring_titles as mt
