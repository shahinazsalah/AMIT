class Student:
    _id_student=1
    def __init__(self,name):
        self.name=name
        self.Student_id=Student._id_student
        Student._id_student+=1
        self.grades={}
        self.enrolled_courses=[]

    def __str__(self):
        return f"std_id : {self.Student_id} , Name std : {self.name} , grade std is : {self.grades}"

    def __repr__(self):
        return f"std_id : {self.Student_id} , Name std : {self.name} , grade std is : {self.grades}, enroll{self.enrolled_courses}"
    
    def add_grade(self,course_id,grade):
        self.grades[course_id]=grade
    
    def enroll_in_course(self,course):
        self.enrolled_courses.append(course)
