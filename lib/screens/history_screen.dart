import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AttendanceProvider>(context);
    var history = provider.history;

    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Kehadiran'),
      ),
      body: history.isEmpty
          ? Center(child: Text('Belum ada riwayat'))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                var record = history[index];
                return ListTile(
                  title: Text(
                      'Tanggal: ${record.date.toLocal().toString().split(' ')[0]}'),
                  subtitle: Text(
                      'Hadir: ${record.presentCount}, Tidak Hadir: ${record.absentCount}'),
                );
              },
            ),
    );
  }
}
