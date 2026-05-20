-- Завдання:
--      Знайти студентів, чий середній бал перевищує середній бал їхньої групи
--      Використати два CTE: один для середнього балу студента, інший для середнього балу групи
--      Очікувані колонки результату:
--          - ідентифікатор студента (student_id)
--          - повне ім'я студента (full_name)
--          - назва групи (group_name)
--          - середній бал студента (avg_student_grade) - округлити результат до 2 знаків після коми
--          - середній бал групи (avg_group_grade) - округлити результат до 2 знаків після коми
--      Результат відсортувати за:
--          - назвою групи, потім за середнім балом студента (спадання), потім за іменем студента

-- Рішення:
with st_averages as (
    select 
        s.student_id,
        p.first_name || ' ' || p.last_name as full_name,
        sg.name as group_name,
        s.group_id,
        round(avg(e.grade), 2) as avg_student_grade
    from student s
    join person p on s.person_id = p.person_id
    join student_group sg on s.group_id = sg.group_id
    join enrolment e on s.student_id = e.student_id
    group by s.student_id, p.first_name, p.last_name, sg.group_id, sg.name
)
select 
    sa.student_id, sa.full_name, sa.group_name, sa.avg_student_grade,
    (select round(avg(en.grade), 2) from student st join enrolment en on st.student_id = en.student_id where st.group_id = sa.group_id) as avg_group_grade
from st_averages sa
where sa.avg_student_grade > (
    select round(avg(en.grade), 2) from student st join enrolment en on st.student_id = en.student_id where st.group_id = sa.group_id
)
order by sa.group_name, sa.avg_student_grade desc, sa.full_name, sa.student_id;