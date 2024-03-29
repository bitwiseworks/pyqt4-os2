// qwizard.sip generated by MetaSIP
//
// This file is part of the QtGui Python extension module.
//
// Copyright (c) 2018 Riverbank Computing Limited <info@riverbankcomputing.com>
// 
// This file is part of PyQt4.
// 
// This file may be used under the terms of the GNU General Public License
// version 3.0 as published by the Free Software Foundation and appearing in
// the file LICENSE included in the packaging of this file.  Please review the
// following information to ensure the GNU General Public License version 3.0
// requirements will be met: http://www.gnu.org/copyleft/gpl.html.
// 
// If you do not wish to use this file under the terms of the GPL version 3.0
// then you may purchase a commercial license.  For more information contact
// info@riverbankcomputing.com.
// 
// This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE
// WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.


%If (Qt_4_3_0 -)

class QWizard : QDialog
{
%TypeHeaderCode
#include <qwizard.h>
%End

public:
    enum WizardButton
    {
        BackButton,
        NextButton,
        CommitButton,
        FinishButton,
        CancelButton,
        HelpButton,
        CustomButton1,
        CustomButton2,
        CustomButton3,
        Stretch,
    };

    enum WizardPixmap
    {
        WatermarkPixmap,
        LogoPixmap,
        BannerPixmap,
        BackgroundPixmap,
    };

    enum WizardStyle
    {
        ClassicStyle,
        ModernStyle,
        MacStyle,
        AeroStyle,
    };

    enum WizardOption
    {
        IndependentPages,
        IgnoreSubTitles,
        ExtendedWatermarkPixmap,
        NoDefaultButton,
        NoBackButtonOnStartPage,
        NoBackButtonOnLastPage,
        DisabledBackButtonOnLastPage,
        HaveNextButtonOnLastPage,
        HaveFinishButtonOnEarlyPages,
        NoCancelButton,
        CancelButtonOnLeft,
        HaveHelpButton,
        HelpButtonOnRight,
        HaveCustomButton1,
        HaveCustomButton2,
        HaveCustomButton3,
    };

    typedef QFlags<QWizard::WizardOption> WizardOptions;
    QWizard(QWidget *parent /TransferThis/ = 0, Qt::WindowFlags flags = 0);
    virtual ~QWizard();
    int addPage(QWizardPage *page /Transfer/);
    void setPage(int id, QWizardPage *page /Transfer/);
    QWizardPage *page(int id) const;
    bool hasVisitedPage(int id) const;
    QList<int> visitedPages() const;
    void setStartId(int id);
    int startId() const;
    QWizardPage *currentPage() const;
    int currentId() const;
    virtual bool validateCurrentPage();
    virtual int nextId() const;
    void setField(const QString &name, const QVariant &value);
    QVariant field(const QString &name) const;
    void setWizardStyle(QWizard::WizardStyle style);
    QWizard::WizardStyle wizardStyle() const;
    void setOption(QWizard::WizardOption option, bool on = true);
    bool testOption(QWizard::WizardOption option) const;
    void setOptions(QFlags<QWizard::WizardOption> options);
    QFlags<QWizard::WizardOption> options() const;
    void setButtonText(QWizard::WizardButton which, const QString &text);
    QString buttonText(QWizard::WizardButton which) const;
    void setButtonLayout(const QList<QWizard::WizardButton> &layout);
    void setButton(QWizard::WizardButton which, QAbstractButton *button /Transfer/);
    QAbstractButton *button(QWizard::WizardButton which) const /Transfer/;
    void setTitleFormat(Qt::TextFormat format);
    Qt::TextFormat titleFormat() const;
    void setSubTitleFormat(Qt::TextFormat format);
    Qt::TextFormat subTitleFormat() const;
    void setPixmap(QWizard::WizardPixmap which, const QPixmap &pixmap);
    QPixmap pixmap(QWizard::WizardPixmap which) const;
    void setDefaultProperty(const char *className, const char *property, SIP_PYOBJECT changedSignal /TypeHint="QT_SIGNAL"/);
%MethodCode
        typedef const char *(*pyqt4_get_signal_t)(PyObject *);
        
        static pyqt4_get_signal_t pyqt4_get_signal = 0;
        
        if (!pyqt4_get_signal)
        {
            pyqt4_get_signal = (pyqt4_get_signal_t)sipImportSymbol("pyqt4_get_signal");
            Q_ASSERT(pyqt4_get_signal);
        }
        
        const char *sig = pyqt4_get_signal(a2);
            
        // Finish converting the arguments.
        if (sig)
        {
            sipCpp->setDefaultProperty(a0, a1, sig);
        }
        else
        {
            sipError = sipBadCallableArg(2, a2);
        }
%End

    virtual void setVisible(bool visible);
    virtual QSize sizeHint() const;

signals:
    void currentIdChanged(int id);
    void helpRequested();
    void customButtonClicked(int which);

public slots:
    void back();
    void next();
    void restart();

protected:
    virtual bool event(QEvent *event);
    virtual void resizeEvent(QResizeEvent *event);
    virtual void paintEvent(QPaintEvent *event);
%If (- Qt_5_0_0)
%If (WS_WIN)
    bool winEvent(MSG *message, long *result);
%End
%If (WS_OS2)
    bool pmEvent(QMSG *message, MRESULT *result);
%End
%End
    virtual void done(int result);
    virtual void initializePage(int id);
    virtual void cleanupPage(int id);

public:
%If (Qt_4_5_0 -)
    void removePage(int id);
%End
%If (Qt_4_5_0 -)
    QList<int> pageIds() const;
%End
%If (Qt_4_7_0 -)
    void setSideWidget(QWidget *widget /Transfer/);
%End
%If (Qt_4_7_0 -)
    QWidget *sideWidget() const;
%End

signals:
%If (Qt_4_7_0 -)
    void pageAdded(int id);
%End
%If (Qt_4_7_0 -)
    void pageRemoved(int id);
%End

private:
    QWizard(const QWizard &);
};

%End
%If (Qt_4_3_0 -)
QFlags<QWizard::WizardOption> operator|(QWizard::WizardOption f1, QFlags<QWizard::WizardOption> f2);
%End
%If (Qt_4_3_0 -)

class QWizardPage : QWidget
{
%TypeHeaderCode
#include <qwizard.h>
%End

public:
%If (Qt_5_0_0 -)
    explicit QWizardPage(QWidget *parent /TransferThis/ = 0);
%End
%If (- Qt_5_0_0)
    QWizardPage(QWidget *parent /TransferThis/ = 0);
%End
%If (Qt_5_0_0 -)
    virtual ~QWizardPage();
%End
    void setTitle(const QString &title);
    QString title() const;
    void setSubTitle(const QString &subTitle);
    QString subTitle() const;
    void setPixmap(QWizard::WizardPixmap which, const QPixmap &pixmap);
    QPixmap pixmap(QWizard::WizardPixmap which) const;
    void setFinalPage(bool finalPage);
    bool isFinalPage() const;
    void setCommitPage(bool commitPage);
    bool isCommitPage() const;
    void setButtonText(QWizard::WizardButton which, const QString &text);
    QString buttonText(QWizard::WizardButton which) const;
    virtual void initializePage();
    virtual void cleanupPage();
    virtual bool validatePage();
    virtual bool isComplete() const;
    virtual int nextId() const;

signals:
    void completeChanged();

protected:
    void setField(const QString &name, const QVariant &value);
    QVariant field(const QString &name) const;
    void registerField(const QString &name, QWidget *widget, const char *property = 0, SIP_PYOBJECT changedSignal /TypeHint="QT_SIGNAL"/ = 0) [void (const QString &name, QWidget *widget, const char *property = 0, const char *changedSignal = 0)];
%MethodCode
        typedef const char *(*pyqt4_get_signal_t)(PyObject *);
        
        static pyqt4_get_signal_t pyqt4_get_signal = 0;
        
        if (!pyqt4_get_signal)
        {
            pyqt4_get_signal = (pyqt4_get_signal_t)sipImportSymbol("pyqt4_get_signal");
            Q_ASSERT(pyqt4_get_signal);
        }
        
        const char *sig = 0;
        
        if (a3 && a3 != Py_None)
        {
            sig = pyqt4_get_signal(a3);
        
            if (!sig)
                sipError = sipBadCallableArg(3, a3);
        }
        
        if (sipError == sipErrorNone)
        {
        #if defined(SIP_PROTECTED_IS_PUBLIC)
            sipCpp->registerField(*a0, a1, a2, sig);
        #else
            sipCpp->sipProtect_registerField(*a0, a1, a2, sig);
        #endif
        }
%End

    QWizard *wizard() const;

private:
    QWizardPage(const QWizardPage &);
};

%End
%If (Qt_4_3_0 -)
// Mapped type for QList<QWizard::WizardButton>.
%MappedType QList<QWizard::WizardButton> /TypeHint="List[QWizard.WizardButton]", TypeHintValue="[]"/
{
%TypeHeaderCode
#include <qwizard.h>
%End

%ConvertFromTypeCode
    // Create the list.
    PyObject *l;

    if ((l = PyList_New(sipCpp->size())) == NULL)
        return NULL;

    // Set the list elements.
    for (int i = 0; i < sipCpp->size(); ++i)
    {
        QWizard::WizardButton e = sipCpp->at(i);
        PyObject *eobj;

        if ((eobj = sipConvertFromEnum(e, sipType_QWizard_WizardButton)) == NULL)
        {
            Py_DECREF(l);

            return NULL;
        }

        PyList_SET_ITEM(l, i, eobj);
    }

    return l;
%End

%ConvertToTypeCode
    // Check the type if that is all that is required.
    if (sipIsErr == NULL)
    {
        if (!PyList_Check(sipPy))
            return 0;

        for (SIP_SSIZE_T i = 0; i < PyList_GET_SIZE(sipPy); ++i)
            if (!sipCanConvertToEnum(PyList_GET_ITEM(sipPy, i), sipType_QWizard_WizardButton))
                return 0;

        return 1;
    }

    QList<QWizard::WizardButton> *ql = new QList<QWizard::WizardButton>;
 
    for (SIP_SSIZE_T i = 0; i < PyList_GET_SIZE(sipPy); ++i)
    {
        long l = SIPLong_AsLong(PyList_GET_ITEM(sipPy, i));
        ql->append(static_cast<QWizard::WizardButton>(l));
    }
 
    *sipCppPtr = ql;
 
    return sipGetState(sipTransferObj);
%End
};
%End
