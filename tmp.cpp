#include "tmp.h"
#include "ui_tmp.h"
#include "login.h"
#include <QString>
#include <QSqlDatabase>
#include <QMessageBox>

Tmp::Tmp(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Tmp)
{
    ui->setupUi(this);
    setAttribute(Qt::WA_DeleteOnClose, true);
    this->parent = (Login *) parent;
    accept = false;
    connect(ui->connectDBButton, &QPushButton::clicked, this, &Tmp::connectAttempt);
    open();
}

Tmp::~Tmp()
{
    delete ui;
    if (!accept) {
        parent->close();
    }
}

void Tmp::connectAttempt() {
    QString hostName = ui->hostNameEdit->text();
    int port = ui->portEdit->text().toInt();
    QString databaseName = ui->databaseNameEdit->text();
    QString userName = ui->userNameEdit->text();
    QString password = ui->passwordEdit->text();

    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL", "Freezer");
    db.setHostName(hostName);
    db.setPort(port);
    db.setDatabaseName(databaseName);
    db.setUserName(userName);
    db.setPassword(password);
    bool ok = db.open();
    if (ok) {
        parent->setDB();
        accept = true;
        close();
    } else {
        QMessageBox::warning(this, "Ошибка", "Неверные данные");
    }
}
