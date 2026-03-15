#include"LoginViewModel.h"
#include<QDebug>

#include "SecurePasswordInput.h"

LoginViewModel::LoginViewModel(DiaryManager &manager, QObject *parent)
    : QObject(parent), m_diaryManager(manager){}

void LoginViewModel::authenticate(SecurePasswordInput *passwordField){
    if (!passwordField) {
        qCritical() << "Error: Password field is null.";
        return;
    }

    QString dbPath = "secure_vault.db";
    if(m_diaryManager.openDiary(dbPath,passwordField->getSecureBuffer())==DiaryError::None){
        qDebug() << "ViewModel: Login successful. Firing success signal to QML.";
        passwordField->clearPassword();
        emit loginSuccess();
    }else{
        qDebug() << "ViewModel: Login failed. Firing failure signal to QML.";
        passwordField->clearPassword();
        emit loginFailed();
    }
    passwordField->clearPassword();
}
