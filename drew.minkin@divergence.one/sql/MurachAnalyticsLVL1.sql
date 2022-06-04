/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
      D.DepartmentName
	  ,COUNT(DISTINCT C.[CourseID]) CourseCount
	  ,COUNT(SC.[CourseID]) StudentCount
	  ,COUNT(distinct I.instructorid) InstructorCount
	  ,ROUND((COUNT(SC.[CourseID])* 1.0/
	  COUNT(distinct I.instructorid)* 1.0),2) StudentsPerInstructor
  FROM [MurachCollege].[dbo].[Courses] C
  JOIN MurachCollege.dbo.Departments D
  ON d.DepartmentID = c.DepartmentID
  JOIN MurachCollege.dbo.StudentCourses SC
  ON C.[CourseID] = SC.[CourseID]
  JOIN MurachCollege.dbo.Instructors I
  ON I.InstructorID = C.InstructorID
GROUP BY       D.DepartmentName