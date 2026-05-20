-- Завдання:
--      Знайти топ-5 студентів у кожному курсі за отриманими балами
--      Очікувані колонки результату:
--          - назва курсу (course_name)
--          - ідентифікатор студента (student_id)
--          - повне ім'я студента (student_full_name)
--          - бал (grade)
--          - ранг (rank) - за балом, іменем студента та ідентифікатором студента
--      Результат відсортувати за:
--          - назвою курсу, потім за рангом (зростання), потім за іменем студента, потім за ідентифікатором студента

-- Рішення:
with ranked_list as (
    select 
        c.name as course_name,
        s.student_id,
        p.first_name || ' ' || p.last_name as student_full_name,
        e.grade,
        rank() over (
            partition by e.course_id 
            order by e.grade desc, p.first_name || ' ' || p.last_name, s.student_id
        ) as rnk
    from enrolment e
    join course c on e.course_id = c.course_id
    join student s on e.student_id = s.student_id
    join person p on s.person_id = p.person_id
    where e.grade is not null
)
select course_name, student_id, student_full_name, grade, rnk as rank
from ranked_list
where rnk <= 5
order by course_name, rank asc, student_full_name, student_id;