#ifndef TMP_H
#define TMP_H

#include <QDialog>

class Login;

namespace Ui {
class Tmp;
}

class Tmp : public QDialog
{
    Q_OBJECT

public:
    explicit Tmp(QWidget *parent = nullptr);
    ~Tmp();

public slots:

    void connectAttempt();

private:
    Ui::Tmp *ui;

    //temp
    Login *parent;
    bool accept;
};

#endif // TMP_H
