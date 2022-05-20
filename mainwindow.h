#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QSqlDatabase>
#include <QSqlTableModel>
#include <QSqlQueryModel>

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

    void fillFood();

    void fillAvailableDishes();
    void fillLendDishes();
    void fillUnavailableDishes();

    void fillRecipeDetail(int idDish);

    void listOfAparts(const QModelIndex &ind);

    void addFood();

    void deleteFood();

    //Переходы по страницам
    void goToMainPage();
    void goToAddFoodPage();
    void goToRecipesPage();
    void goToRecipeDetailPage(const QModelIndex &ind);

signals:

    void apartIdChanged(int newId);

private:
    Ui::MainWindow *ui;
    Login *loginWindow;
    int apartId;
    QSqlDatabase db;
    QSqlTableModel *foodModel;       //products.name, food.date_manuf, food.product_id
    QSqlTableModel *products;
    QSqlTableModel *availableDishesModel;
    QSqlTableModel *lendDishesModel;
    QSqlTableModel *unavailableDishesModel;
    QSqlQueryModel *recipeDetailModel;
};
#endif // MAINWINDOW_H
