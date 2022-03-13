#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QSqlDatabase>
#include <QSqlQueryModel>
#include <QSqlTableModel>

class Login;

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

public slots:

    //temp
    void setDB();

    void setApartId(int id);

    void fillFood(int id);

    void addFood();

    //Переходы по страницам
    void goToMainPage();
    void goToAddFoodPage();

signals:

    void apartIdChanged(int newId);

private:
    Ui::MainWindow *ui;
    Login *loginWindow;
    int apartId;
    QSqlDatabase db;
    QSqlQueryModel *foodModel;       //products.name, food.date_manuf, food.product_id
    QSqlTableModel *products;
};
#endif // MAINWINDOW_H
