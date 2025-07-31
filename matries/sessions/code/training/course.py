class course:
    _id_counter = 1 

    def __init__(self,name):
        self.course_id=course._id_counter
        course._id_counter+=1
        self.name=name
        self.enrolled_std=[]
    def __str__(self):
        return f"course id : {self.course_id} , name {self.name}, enroll :{len(self.enrolled_std)}"

    def enrolled_st(self,student):
        if student not in enrolled_st:
            self.enrolled_std.append(student)
            print("std enroll succ")
        else:
            print("std already enroll")
    
    def remove_std(self,student):
        for course in self.Courses.values():
            if student in course.enrolled_std:
                course.enrolled_std.remove(student)