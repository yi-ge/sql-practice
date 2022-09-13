-- 1077. 项目员工 III
-- https://leetcode.cn/problems/project-employees-iii/
select Project.*
from Project,
  Employee
where (Project.project_id, experience_years) in (
    select Project.project_id,
      max(Employee.experience_years) as experience_years
    from Project,
      Employee
    where Project.employee_id = Employee.employee_id
    group by Project.project_id
  )
  and Project.employee_id = Employee.employee_id