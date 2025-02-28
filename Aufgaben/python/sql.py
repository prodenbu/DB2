import mysql.connector
db = mysql.connector.connect(
    host="localhost",
    user="user",
    password="password",
    database="DB2",
)


def main():
    print("Hallo Welt")
    print(db)
    c = db.cursor()
    c.execute("SELECT * FROM Students")
    for s in c:
        print("Studentname: "  + s[1])
    c.execute("SELECT * FROM Schools")
    for s in c:
        print("School Identifier: "  + s[1])
    c.execute("SELECT COUNT(*) FROM Schools")
    for s in c:
        print("Total amount of Schools: "  + str(s[0]))
    c.execute("SELECT COUNT(*) FROM Students")
    for s in c:
        print("Total amount of Students: "  + str(s[0]))
    c.execute("SELECT s.* FROM Students s JOIN Schools sc on s.School_ID = sc.ID WHERE sc.ID = 3")
    r = c.fetchall()
    for s in r:
        print("Student at school 1: "  + str(s[1]))
    c.execute("SELECT sc.* FROM Schools sc JOIN Students s on s.School_ID = sc.ID WHERE s.ID = 4")
    r = c.fetchall()
    for s in r:
        print("Student 1 is at School: " + s[1])


if __name__ == "__main__":
    main()
