-- Завдання:
--      Сформувати єдиний список активностей університету, що поєднує:
--          - записи студентів на курси
--          - призначення викладачів на курси
--      Очікувані колонки результату:
--          - повне ім'я (full_name)
--          - назва курсу (course_name)
--          - тип активності (activity_type) - 'запис на курс' або 'викладання курсу'
--      Включити тільки активні курси (статус 'активний')
--      Результат відсортувати за:
--          - назвою курсу, потім за типом активності, потім за іменем

-- Рішення:
select p.first_name || ' ' || p.last_name as full_name, c.name as course_name, 'запис на курс' as activity_type
from enrolment e
join student s on e.student_id = s.student_id
join person p on s.person_id = p.person_id
join course c on e.course_id = c.course_id
where c.status = 'активний'

union all

select p.first_name || ' ' || p.last_name as full_name, c.name as course_name, 'викладання курсу' as activity_type
from course_teacher ct
join professor prof on ct.professor_id = prof.professor_id
join person p on prof.person_id = p.person_id
join course c on ct.course_id = c.course_id
where c.status = 'активний'
order by course_name, activity_type, full_name;