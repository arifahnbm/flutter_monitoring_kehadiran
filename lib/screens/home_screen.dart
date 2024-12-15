import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';
import '../widgets/student_list_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AttendanceProvider>(context);
    var students = provider.students;

    return Scaffold(
      appBar: AppBar(
        title: Text('Presensi Siswa'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return StudentListItem(index: index);
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          backgroundColor:
              provider.students.isEmpty ? Colors.grey : Colors.blue,
          onPressed: () {
            final currentDate = DateTime.now().toString().split(' ')[0];
            int presentCount = students.where((s) => s.isPresent).length;
            int absentCount = students.length - presentCount;
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: Text('Simpan Kehadiran'),
                      content: 
                         Column(
                           children: [
                             Text('Tanggal: $currentDate'),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Hadir: $presentCount'), Text('Tidak Hadir: $absentCount')
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                final anyStudents
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(students), Text('Tidak Hadir: $absentCount')
                                ],
                              )
                           ],
                         ),
                         
                      ),
                    );
            
            provider.students.isEmpty ? null : provider.saveAttendance();
          }),
    );
  }
}
