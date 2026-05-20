-- Завдання:
--      Знайти викладачів зі статусом 'викладає', які не є куратором жодної студентської групи
--      Очікувані колонки результату:
--          - повне ім'я викладача (professor_name)
--          - посада (job)
--      Результат відсортувати за:
--          - повним іменем викладача

-- Рішення:
select 
    p.first_name || ' ' || p.last_name as professor_name,
    prof.job
from professor prof
join person p on prof.person_id = p.person_id
where prof.status = 'викладає' 
  and prof.professor_id not in (
      select curator_id from student_group where curator_id is not null
  )
order by professor_name;