#include <QString>
#include <QtTest>

class TestBasic : public QObject
{
    Q_OBJECT

public:
    TestBasic();

private Q_SLOTS:
    void testDBOperations();
};

TestBasic::TestBasic()
{
}

void TestBasic::testDBOperations()
{
    QVERIFY2(true, "Failure");
}

QTEST_APPLESS_MAIN(TestBasic)

#include "tst_testbasic.moc"
