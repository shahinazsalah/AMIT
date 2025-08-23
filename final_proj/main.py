from PyQt5.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt5 import uic
import sys
import psycopg2


class HospitalApp(QMainWindow):
    def __init__(self):
        super(HospitalApp, self).__init__()
        
        # تحميل ملف الـ UI
        uic.loadUi("D:/AMIT/matries/sessions/code/final_proj/hospital.ui", self)
        self.setWindowTitle("Hospital Management System")

        # ✅ تحميل ملف الستايل
        try:
            with open("D:/AMIT/matries/sessions/code/final_proj/style.qss", "r") as f:
                self.setStyleSheet(f.read())
            print("🎨 Style loaded successfully")
        except Exception as e:
            print("⚠️ Style Error:", e)

        # DB Connection
        self.handle_db_conn()

        # Events
        self.handle_buttons()

    def handle_db_conn(self):
        try:
            self.db = psycopg2.connect(
                host="localhost",
                database="hospital",
                user="postgres",
                password="shahy123"
            )
            self.curr = self.db.cursor()
            print("✅ DB Connected")
        except Exception as e:
            print("❌ DB Error:", e)

    def handle_buttons(self):
        pass


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = HospitalApp()
    window.show()
    sys.exit(app.exec_())
