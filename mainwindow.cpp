#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "login.h"
#include <QSqlQuery>
#include <QSqlTableModel>
#include <QSqlRecord>
#include <QMessageBox>
#include <QStyledItemDelegate>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
    , apartId(0)
{
    ui->setupUi(this);
    setAttribute(Qt::WA_DeleteOnClose, true);
    loginWindow = new Login(this);
//    db = QSqlDatabase::database("Freezer");
//    foodModel = new QSqlQueryModel;
//    products = new QSqlTableModel(this, db);
//    products->setTable("products");
//    products->select();

//    ui->foodBox->setModel(products);
//    ui->foodBox->setModelColumn(1);

//    connect(this, &MainWindow::apartIdChanged, this, &MainWindow::fillFood);
//    connect(ui->addFoodButton, &QPushButton::clicked, this, &MainWindow::addFood);
//    connect(ui->quitAddFoodButton, &QPushButton::clicked, this, &MainWindow::goToMainPage);
//    connect(ui->goToAddFoodButton, &QPushButton::clicked, this, &MainWindow::goToAddFoodPage);
}

MainWindow::~MainWindow()
{
    delete ui;
    delete foodModel;
}

void MainWindow::setApartId(int id) {
    apartId = id;
    emit apartIdChanged(id);
}

bool MainWindow::checkExpireDate(int foodId) {
    QSqlQuery query(db);
    QString q = "SELECT DATEDIFF(NOW(), food.date_manuf) > products.expir_date "
                    "FROM food "
                    "JOIN products ON food.id_product = products.id "
                    "WHERE food.id_apart = " + QString::number(apartId) + " AND food.id = " + QString::number(foodId);
    query.exec(q);
    query.next();

    return query.value(0).toInt();
}

void MainWindow::fillFood(int id) {
    QString query = "SELECT products.name as name, food.date_manuf as date, food.id_product, food.id FROM "
                        "food "
                        "JOIN products ON food.id_product = products.id "
                        "WHERE food.id_apart = " + QString::number(id);
    foodModel->setQuery(query, db);
    foodModel->setHeaderData(0, Qt::Horizontal, tr("Название продукта"));
    foodModel->setHeaderData(1, Qt::Horizontal, tr("Дата изготовления"));

    //Таблица с едой и датой
    ui->foodTable->setModel(foodModel);
    ui->foodTable->hideColumn(2);
    ui->foodTable->hideColumn(3);
    ui->foodTable->horizontalHeader()->setSectionResizeMode(0, QHeaderView::Stretch);
    ui->foodTable->horizontalHeader()->setSectionResizeMode(1, QHeaderView::Stretch);

    for (int i = 0; i < ui->foodTable->model()->rowCount(); i++) {
        int foodId = ui->foodTable->model()->index(i, 3).data().toInt();
        if (checkExpireDate(foodId)) {
            ui->foodTable->model()->setData(ui->foodTable->model()->index(i, 0), QColor(Qt::red), Qt::BackgroundRole);
            ui->foodTable->model()->setData(ui->foodTable->model()->index(i, 1), QColor(Qt::red), Qt::BackgroundRole);
        }
    }
}

void MainWindow::addFood() {
    QString id_product = products->record(ui->foodBox->currentIndex()).value(0).toString();
    QString date_manuf = ui->dateManufEdit->date().toString("yyyy-MM-dd");
    QSqlQuery query(db);
    QString q = "INSERT INTO food (id_product, id_apart, date_manuf) VALUES"
                    "(" + id_product + ", " + QString::number(apartId) + ", \"" + date_manuf + "\")";
    bool ok = query.exec(q);
    if (ok) {
        QMessageBox::information(this, "Успех", "Еда успешно добавлена");
        fillFood(apartId);
    } else {
        QMessageBox::warning(this, "Ошибка", "Произошла ошибка при добавлении еды в базу данных");
    }
}

void MainWindow::goToMainPage() {
    ui->stackedWidget->setCurrentWidget(ui->mainPage);
}

void MainWindow::goToAddFoodPage() {
    ui->stackedWidget->setCurrentWidget(ui->addFoodPage);
}

void MainWindow::deleteFood() {
    int row = ui->foodTable->currentIndex().row();
    QModelIndex foodIndex = ui->foodTable->model()->index(row, 3);
    QVariant foodId = foodIndex.data();

    QSqlQuery query(db);
    QString q = "DELETE FROM food WHERE id = " + foodId.toString();
    bool ok = query.exec(q);
    if (ok){
        QMessageBox::information(this, "Успех", "Еда успешно удалена из списка");
        fillFood(apartId);
    } else {
        QMessageBox::warning(this, "Ошибка", "Произошла ошибка при попытке удаления еды");
    }
}

//temp
void MainWindow::setDB() {
    db = QSqlDatabase::database("Freezer");
    foodModel = new QSqlQueryModel;
    products = new QSqlTableModel(this, db);
    products->setTable("products");
    products->select();

    ui->foodBox->setModel(products);
    ui->foodBox->setModelColumn(1);

    connect(this, &MainWindow::apartIdChanged, this, &MainWindow::fillFood);
    connect(ui->addFoodButton, &QPushButton::clicked, this, &MainWindow::addFood);
    connect(ui->quitAddFoodButton, &QPushButton::clicked, this, &MainWindow::goToMainPage);
    connect(ui->goToAddFoodButton, &QPushButton::clicked, this, &MainWindow::goToAddFoodPage);
    connect(ui->deleteFoodButton, &QPushButton::clicked, this, &MainWindow::deleteFood);
}
