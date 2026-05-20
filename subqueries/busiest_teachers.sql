-- Завдання:
--      Знайти топ-100 викладачів, що мають найбільшу кількість кредитів
--      Очікувані колонки результату:
--          - повне ім'я викладача (full_name)
--          - загальна кількість кредитів (total_credits)
--          - середня кількість кредитів серед усіх викладачів (avg_total_credits) - округлити результат до 2 знаків після коми
--      Результат відсортувати за:
--          - кількістю кредитів (спадання), потім за ім'ям

-- Рішення:
with credits_per_teacher as (
    select 
        p.first_name || ' ' || p.last_name as full_name,
        sum(c.credits) as total_credits
    from professor pr
    join person p on pr.person_id = p.person_id
    join course_teacher ct on pr.professor_id = ct.professor_id
    join course c on ct.course_id = c.course_id
    group by pr.professor_id, p.first_name, p.last_name
)
select 
    full_name,
    total_credits,
    round((select avg(total_credits) from credits_per_teacher), 2) as avg_total_credits
from credits_per_teacher
order by total_credits desc, full_name
limit 100;