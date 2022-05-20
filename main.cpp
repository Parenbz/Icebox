#include "mainwindow.h"
#include "tmp.h"

#include <QApplication>
#include <QSqlDatabase>
#include <QMessageBox>
#include <QSqlError>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.setWindowTitle("Система холодильников");
    return a.exec();
}
