#include "login.h"
#include "ui_login.h"
#include "mainwindow.h"
#include "tmp.h"
#include <QMessageBox>
#include <QSqlDatabase>
#include <QSqlQuery>

Login::Login(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Login)
{
    ui->setupUi(this);
    setAttribute(Qt::WA_DeleteOnClose, true);
    this->parent = (MainWindow *) parent;
    setWindowTitle("Авторизация");
    connect(ui->logButton, &QPushButton::clicked, this, &Login::loginAttempt);
    show();
    accept = false;
    tmp = new Tmp(this);
//    db = QSqlDatabase::database("Freezer");
}

Login::~Login()
{
    delete ui;
    if (!accept) {
        parent->close();
    }
}

void Login::loginAttempt() {
    int password = ui->passwordLine->text().toInt();

    QSqlQuery query(db);
    query.exec("SELECT * FROM apartaments");

    while (query.next()) {
        if (query.value(1).toInt() == password) {
            parent->setApartId(query.value(0).toInt());
            parent->show();
            accept = true;
            close();
            break;
        }
    }

    if (!accept) QMessageBox::warning(this, "Ошибка", "Неправильный пароль");
}

void Login::setDB() {
    db = QSqlDatabase::database("Freezer");
    parent->setDB();
}
