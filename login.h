#ifndef LOGIN_H
#define LOGIN_H

#include <QDialog>
#include <QSqlDatabase>

class MainWindow;
class Tmp;

namespace Ui {
class Login;
}

class Login : public QDialog
{
    Q_OBJECT

public:
    explicit Login(QWidget *parent = nullptr);
    ~Login();

public slots:

    //temp
    void setDB();

private slots:

    void loginAttempt();

private:
    Ui::Login *ui;
    bool accept;
    MainWindow *parent;
    QSqlDatabase db;

    //temp
    Tmp *tmp;
};

#endif // LOGIN_H
