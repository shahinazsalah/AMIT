from course import course
from std import Student


class systemManager:
    def __init__(self):
        self.students={}
        self.courses={}

    def add_std(self,name):
        student =Student(name)
        self.students[student.Student_id]=student
        print("std added succ")
        return student.Student_id
    def remove_std(self,Student_id):
        if Student_id in self.students:
            student=self.students[Student_id]
            if not student.enrolled_courses:
                del self.students[Student_id]
                print("student removed successfully")
            else:
                print("student is already enrolled in the course")
                
        else:
            print("Invalid student or course ID")

    def enrolled_course(self, Student_id , course_id):
        if Student_id in self.students and course_id in self.courses:
            student = self.students[Student_id]
            course  = self.courses[course_id]

            if course.name not in student.enrolled_courses:
                student.enroll_in_course(course.name)
                course.enrolled_std(student.name)
                print("student enrolled in courses successfully")
            else:
                print("student is already enrolled in the course")
        else:
            print("Invalid student or course ID")
    

    def record_grade(self,Student_id , course_id , grade):
        if Student_id in self.students and course_id in self.courses:
            student = self.students[Student_id]
            course  = self.courses[course_id]
            student.add_grade(course.name,grade)
            print("grade succ")
        else:
            print("invalid")


    def get_all_std(self):
        return list(self.student.values)
    def get_all_cous(self):
        return list(self.course.values)