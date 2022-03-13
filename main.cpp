#include "mainwindow.h"
#include "tmp.h"

#include <QApplication>
#include <QSqlDatabase>
#include <QMessageBox>
#include <QSqlError>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
//    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL", "Freezer");
//    db.setHostName("127.0.0.1");
//    db.setPort(3306);
//    db.setDatabaseName("icebox");
//    db.setUserName("root");
//    db.setPassword("root");
//    bool ok = db.open();
//    if (!ok) {
//        QMessageBox::information(nullptr, "Error", db.lastError().text());
//        return 1;
//    }
    MainWindow w;
    w.setWindowTitle("Система холодильников");
    return a.exec();
}
