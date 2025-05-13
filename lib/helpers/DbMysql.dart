import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class DbMysql {

  DbMysql();

  Future<MySqlConnection> getConnection() async {
    debugPrint('Start Connection');
    return await MySqlConnection.connect(
        ConnectionSettings(
            host: '192.168.18.24',
            port: 3306,
            user: 'remote',
            password: 'remote',
            db: 'tristart'
        )
    );
  }
}
