#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "login.h"
#include <QSqlQuery>
#include <QSqlTableModel>
#include <QSqlQueryModel>
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
}

MainWindow::~MainWindow()
{
    delete ui;
    delete foodModel;
    delete availableDishesModel;
    delete lendDishesModel;
    delete unavailableDishesModel;
}

void MainWindow::setApartId(int id) {
    apartId = id;
    emit apartIdChanged(id);
}

void MainWindow::fillFood() {
    foodModel->setTable("allfoodtable");
    foodModel->setFilter("id_apart = " + QString::number(apartId));
    foodModel->select();
    foodModel->setHeaderData(0, Qt::Horizontal, tr("Тип продукта"));
    foodModel->setHeaderData(1, Qt::Horizontal, tr("Название продукта"));
    foodModel->setHeaderData(2, Qt::Horizontal, tr("Дата изготовления"));
    foodModel->setHeaderData(6, Qt::Horizontal, tr("Годен до"));

    //Таблица с едой и датой
    ui->foodTable->setModel(foodModel);
    ui->foodTable->hideColumn(3);
    ui->foodTable->hideColumn(4);
    ui->foodTable->hideColumn(5);
    ui->foodTable->horizontalHeader()->setSectionResizeMode(0, QHeaderView::Stretch);
    ui->foodTable->horizontalHeader()->setSectionResizeMode(1, QHeaderView::Stretch);
    ui->foodTable->horizontalHeader()->setSectionResizeMode(2, QHeaderView::Stretch);
    ui->foodTable->horizontalHeader()->setSectionResizeMode(6, QHeaderView::Stretch);
}

void MainWindow::fillAvailableDishes() {
    availableDishesModel->setTable("available_dishes");
    availableDishesModel->setFilter("id_apart = " + QString::number(apartId));
    availableDishesModel->select();
    availableDishesModel->setHeaderData(0, Qt::Horizontal, tr("Можно приготовить"));

    ui->availableRecipeList->setModel(availableDishesModel);
    ui->availableRecipeList->setModelColumn(0);
}

void MainWindow::fillLendDishes() {
    lendDishesModel->setTable("lend_dishes");
    lendDishesModel->select();

    ui->lendRecipeList->setModel(lendDishesModel);
    ui->lendRecipeList->setModelColumn(0);
}

void MainWindow::fillUnavailableDishes() {
    unavailableDishesModel->setTable("unavailable_dishes");
    unavailableDishesModel->select();

    ui->unavailableRecipeList->setModel(unavailableDishesModel);
    ui->unavailableRecipeList->setModelColumn(0);
}

void MainWindow::fillRecipeDetail(int idDish) {
    QString q = "SELECT food_types.type AS food_type, recipes.quantity AS quantity, recipes.commnt AS commnt, food_types.id AS id_food "
                    "FROM recipes "
                    "JOIN food_types ON food_types.id = recipes.id_food "
                    "WHERE recipes.id_dish = " + QString::number(idDish);

    recipeDetailModel->setQuery(q, db);
    recipeDetailModel->setHeaderData(0, Qt::Horizontal, tr("Продукт"));
    recipeDetailModel->setHeaderData(1, Qt::Horizontal, tr("Количество"));
    recipeDetailModel->setHeaderData(2, Qt::Horizontal, tr("Комментарий"));

    ui->recipeDetailTable->setModel(recipeDetailModel);
    ui->recipeDetailTable->hideColumn(3);
    ui->recipeDetailTable->horizontalHeader()->setSectionResizeMode(0, QHeaderView::Stretch);
    ui->recipeDetailTable->horizontalHeader()->setSectionResizeMode(1, QHeaderView::Stretch);
    ui->recipeDetailTable->horizontalHeader()->setSectionResizeMode(2, QHeaderView::Stretch);

    q = "SELECT dishes.name FROM dishes WHERE dishes.id = " + QString::number(idDish);
    QSqlQuery query(db);
    query.exec(q);
    query.next();

    ui->recipeNameLabel->setText(query.value(0).toString());
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
        fillFood();
        fillAvailableDishes();
        fillLendDishes();
        fillUnavailableDishes();
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

void MainWindow::goToRecipesPage() {
    ui->stackedWidget->setCurrentWidget(ui->recipesPage);
}

void MainWindow::goToRecipeDetailPage(const QModelIndex &ind) {
    int idDish = ind.model()->data(ind.model()->index(ind.row(), 1)).toInt();
    fillRecipeDetail(idDish);
    ui->stackedWidget->setCurrentWidget(ui->recipeDetailPage);
}

void MainWindow::deleteFood() {
    int row = ui->foodTable->currentIndex().row();
    QModelIndex foodIndex = foodModel->index(row, 4);
    QVariant foodId = foodIndex.data();

    QSqlQuery query(db);
    QString q = "DELETE FROM food WHERE id = " + foodId.toString();
    bool ok = query.exec(q);
    if (ok){
        QMessageBox::information(this, "Успех", "Еда успешно удалена из списка");
        fillFood();
        fillAvailableDishes();
        fillLendDishes();
        fillUnavailableDishes();
    } else {
        QMessageBox::warning(this, "Ошибка", "Произошла ошибка при попытке удаления еды");
    }
}

void MainWindow::listOfAparts(const QModelIndex &ind) {
    int idFood = ind.model()->data(ind.model()->index(ind.row(), 3)).toInt();
    qDebug() << idFood;
    QString q = "SELECT food_apart.id_apart FROM food_apart WHERE food_apart.type = " + QString::number(idFood);
    QSqlQuery query(db);
    query.exec(q);
    bool ok = query.next();
    if (!ok) {
        QMessageBox::warning(this, "Ошибка", "Такой еды нет ни в одной комнате");
        return;
    }
    QString msg = "Такая еда есть в комнатах: ";
    while (ok) {
        msg += "\n" + QString::number(query.value(0).toInt());
        ok = query.next();
    }
    QMessageBox::information(this, "Помощь", msg);
}

//temp
void MainWindow::setDB() {
    db = QSqlDatabase::database("Freezer");
    foodModel = new QSqlTableModel(this, db);
    products = new QSqlTableModel(this, db);
    availableDishesModel = new QSqlTableModel(this, db);
    lendDishesModel = new QSqlTableModel(this, db);
    unavailableDishesModel = new QSqlTableModel(this, db);
    recipeDetailModel = new QSqlQueryModel;
    products->setTable("products");
    products->select();

    ui->foodBox->setModel(products);
    ui->foodBox->setModelColumn(1);

    connect(this, &MainWindow::apartIdChanged, this, &MainWindow::fillFood);
    connect(this, &MainWindow::apartIdChanged, this, &MainWindow::fillAvailableDishes);
    connect(this, &MainWindow::apartIdChanged, this, &MainWindow::fillLendDishes);
    connect(this, &MainWindow::apartIdChanged, this, &MainWindow::fillUnavailableDishes);
    connect(ui->addFoodButton, &QPushButton::clicked, this, &MainWindow::addFood);
    connect(ui->quitAddFoodButton, &QPushButton::clicked, this, &MainWindow::goToMainPage);
    connect(ui->goToAddFoodButton, &QPushButton::clicked, this, &MainWindow::goToAddFoodPage);
    connect(ui->deleteFoodButton, &QPushButton::clicked, this, &MainWindow::deleteFood);
    connect(ui->goToRecipesButton, &QPushButton::clicked, this, &MainWindow::goToRecipesPage);
    connect(ui->goFromRecipesButton, &QPushButton::clicked, this, &MainWindow::goToMainPage);
    connect(ui->goToRecipesButton_2, &QPushButton::clicked, this, &MainWindow::goToRecipesPage);
    connect(ui->availableRecipeList, &QAbstractItemView::doubleClicked, this, &MainWindow::goToRecipeDetailPage);
    connect(ui->lendRecipeList, &QAbstractItemView::doubleClicked, this, &MainWindow::goToRecipeDetailPage);
    connect(ui->unavailableRecipeList, &QAbstractItemView::doubleClicked, this, &MainWindow::goToRecipeDetailPage);
    connect(ui->recipeDetailTable, &QAbstractItemView::doubleClicked, this, &MainWindow::listOfAparts);
}
