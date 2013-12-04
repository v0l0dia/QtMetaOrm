#-------------------------------------------------
#
# Project created by QtCreator 2013-12-05T00:03:16
#
#-------------------------------------------------

QT       += testlib

QT       -= gui

TARGET = tst_testbasic
CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app


SOURCES += tst_testbasic.cpp
DEFINES += SRCDIR=\\\"$$PWD/\\\"

HEADERS += \
    ../lib/qpo_base.h \
    ../lib/qpo_utils.h \
    ../lib/qpo_sugar.h \
    ../lib/qpo_database.h \
    ../lib/qpo_persistent.h \
    ../lib/qpo_condition.h \
    ../lib/qpo_queryset.h \
    ../lib/qpo_sqltypes.h
