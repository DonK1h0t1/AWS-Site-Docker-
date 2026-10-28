-- =============================================
-- База данных: era_db (Университет)
-- Таблицы: groups, students, courses, grades
-- =============================================

-- 1. Группы
CREATE TABLE groups (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(20) NOT NULL UNIQUE,
    faculty     VARCHAR(100) NOT NULL,
    year_start  INT NOT NULL
);

-- 2. Студенты
CREATE TABLE students (
    id          SERIAL PRIMARY KEY,
    first_name  VARCHAR(50) NOT NULL,
    last_name   VARCHAR(50) NOT NULL,
    email       VARCHAR(100) UNIQUE,
    birth_date  DATE,
    group_id    INT REFERENCES groups(id) ON DELETE SET NULL
);

-- 3. Предметы
CREATE TABLE courses (
    id          SERIAL PRIMARY KEY,
    title       VARCHAR(100) NOT NULL,
    teacher     VARCHAR(100) NOT NULL,
    credits     INT NOT NULL CHECK (credits > 0)
);

-- 4. Оценки
CREATE TABLE grades (
    id          SERIAL PRIMARY KEY,
    student_id  INT NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    course_id   INT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
    score       INT NOT NULL CHECK (score BETWEEN 0 AND 100),
    exam_date   DATE NOT NULL DEFAULT CURRENT_DATE
);

-- ---------- Данные ----------

INSERT INTO groups (name, faculty, year_start) VALUES
('IT-21',  'Информационные технологии', 2021),
('IT-22',  'Информационные технологии', 2022),
('CS-23',  'Кибербезопасность',         2023);

INSERT INTO students (first_name, last_name, email, birth_date, group_id) VALUES
('Алихан',  'Лютов',      'alikhan@era.kz',  '2004-03-15', 1),
('Аружан',  'Сейткали',   'aruzhan@era.kz',  '2004-07-22', 1),
('Диас',    'Нурланов',   'dias@era.kz',     '2003-11-02', 1),
('Мадина',  'Ахметова',   'madina@era.kz',   '2005-01-30', 2),
('Ерлан',   'Касымов',    'erlan@era.kz',    '2005-05-18', 2),
('Айгерим', 'Жумабекова', 'aigerim@era.kz',  '2005-09-09', 2),
('Тимур',   'Ибраев',     'timur@era.kz',    '2006-02-14', 3),
('Камила',  'Оспанова',   'kamila@era.kz',   '2006-06-25', 3);

INSERT INTO courses (title, teacher, credits) VALUES
('Базы данных',          'Смагулов Б.К.', 5),
('Компьютерные сети',    'Иванова Е.А.',  4),
('Операционные системы', 'Тулегенов А.М.',4),
('Кибербезопасность',    'Ким С.В.',      5);

INSERT INTO grades (student_id, course_id, score, exam_date) VALUES
(1, 1, 95, '2026-01-15'), (1, 2, 88, '2026-01-18'), (1, 3, 91, '2026-01-21'),
(2, 1, 78, '2026-01-15'), (2, 2, 85, '2026-01-18'), (2, 4, 90, '2026-01-24'),
(3, 1, 67, '2026-01-15'), (3, 3, 72, '2026-01-21'),
(4, 1, 99, '2026-01-15'), (4, 2, 94, '2026-01-18'),
(5, 2, 55, '2026-01-18'), (5, 3, 61, '2026-01-21'),
(6, 1, 83, '2026-01-15'), (6, 4, 87, '2026-01-24'),
(7, 4, 92, '2026-01-24'), (7, 3, 80, '2026-01-21'),
(8, 4, 76, '2026-01-24'), (8, 1, 89, '2026-01-15');

-- ---------- Представление (VIEW) для удобного просмотра ----------

CREATE VIEW student_report AS
SELECT
    s.first_name || ' ' || s.last_name AS student,
    g.name                             AS group_name,
    c.title                            AS course,
    gr.score
FROM grades gr
JOIN students s ON s.id = gr.student_id
JOIN groups   g ON g.id = s.group_id
JOIN courses  c ON c.id = gr.course_id
ORDER BY student, course;
