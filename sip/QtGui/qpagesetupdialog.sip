// qpagesetupdialog.sip generated by MetaSIP
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


%If (- Qt_5_0_0)
%If (PyQt_PrintDialog)

class QPageSetupDialog : QDialog
{
%TypeHeaderCode
#include <qpagesetupdialog.h>
%End

public:
%If (Qt_4_4_0 -)

    enum PageSetupDialogOption
    {
        DontUseSheet,
    };

%End
%If (Qt_4_4_0 -)
    typedef QFlags<QPageSetupDialog::PageSetupDialogOption> PageSetupDialogOptions;
%End
%If (Qt_4_5_0 -)
    explicit QPageSetupDialog(QWidget *parent /TransferThis/ = 0);
%End
    QPageSetupDialog(QPrinter *printer, QWidget *parent /TransferThis/ = 0);
    virtual int exec() /PostHook=__pyQtPostEventLoopHook__,PreHook=__pyQtPreEventLoopHook__,PyName=exec_,ReleaseGIL/;
%MethodCode
        // Transfer ownership back to Python (a modal dialog will probably have the
        // main window as it's parent).  This means the Qt dialog will be deleted when
        // the Python wrapper is garbage collected.  Although this is a little
        // inconsistent, it saves having to code it explicitly to avoid the memory
        // leak.
        sipTransferBack(sipSelf);
        
        Py_BEGIN_ALLOW_THREADS
        sipRes = sipSelfWasArg ? sipCpp->QPageSetupDialog::exec()
                               : sipCpp->exec();
        Py_END_ALLOW_THREADS
%End

%If (Py_v3)
    virtual int exec() /PostHook=__pyQtPostEventLoopHook__,PreHook=__pyQtPreEventLoopHook__,ReleaseGIL/;
%MethodCode
        // Transfer ownership back to Python (a modal dialog will probably have the
        // main window as it's parent).  This means the Qt dialog will be deleted when
        // the Python wrapper is garbage collected.  Although this is a little
        // inconsistent, it saves having to code it explicitly to avoid the memory
        // leak.
        sipTransferBack(sipSelf);
        
        Py_BEGIN_ALLOW_THREADS
        sipRes = sipSelfWasArg ? sipCpp->QPageSetupDialog::exec()
                               : sipCpp->exec();
        Py_END_ALLOW_THREADS
%End

%End
    QPrinter *printer();
%If (Qt_4_4_0 -)
    void addEnabledOption(QPageSetupDialog::PageSetupDialogOption option);
%End
%If (Qt_4_4_0 -)
    void setEnabledOptions(QFlags<QPageSetupDialog::PageSetupDialogOption> options);
%End
%If (Qt_4_4_0 -)
    QFlags<QPageSetupDialog::PageSetupDialogOption> enabledOptions() const;
%End
%If (Qt_4_4_0 -)
    bool isOptionEnabled(QPageSetupDialog::PageSetupDialogOption option) const;
%End
%If (Qt_4_5_0 -)
    void setOption(QPageSetupDialog::PageSetupDialogOption option, bool on = true);
%End
%If (Qt_4_5_0 -)
    bool testOption(QPageSetupDialog::PageSetupDialogOption option) const;
%End
%If (Qt_4_5_0 -)
    void setOptions(QFlags<QPageSetupDialog::PageSetupDialogOption> options);
%End
%If (Qt_4_5_0 -)
    QFlags<QPageSetupDialog::PageSetupDialogOption> options() const;
%End
%If (Qt_4_5_0 -)
    void open();
%End
%If (Qt_4_5_0 -)
    void open(QObject *receiver, SIP_PYOBJECT member /TypeHint="QT_SLOT"/);
%MethodCode
        const char *slot = pyqt4_qtgui_get_slot(a1);
        
        if (slot)
        {
            Py_BEGIN_ALLOW_THREADS
            sipCpp->open(a0, slot);
            Py_END_ALLOW_THREADS
        }
        else
        {
            sipError = sipBadCallableArg(1, a1);
        }
%End

%End
%If (Qt_4_5_0 -)
    void open(SIP_PYOBJECT slot /TypeHint="PYQT_SLOT"/);
%MethodCode
        QObject *receiver;
        QByteArray slot_signature;
        
        if ((sipError = pyqt4_qtgui_get_connection_parts(a0, 0, "()", false, &receiver, slot_signature)) == sipErrorNone)
        {
            Py_BEGIN_ALLOW_THREADS
            sipCpp->open(receiver, slot_signature.constData());
            Py_END_ALLOW_THREADS
        }
        else if (sipError == sipErrorContinue)
        {
            sipError = sipBadCallableArg(0, a0);
        }
%End

%End
// Public platform specific methods.
%If (WS_WIN || WS_OS2)
virtual void setVisible(bool visible);
%End
%If (WS_MACX)
virtual void setVisible(bool visible);
%End
};

%End
%End
%If (Qt_5_0_0 -)
%If (PyQt_PrintDialog)

class QPageSetupDialog : QDialog
{
%TypeHeaderCode
#include <qpagesetupdialog.h>
%End

public:
    QPageSetupDialog(QPrinter *printer, QWidget *parent /TransferThis/ = 0);
    explicit QPageSetupDialog(QWidget *parent /TransferThis/ = 0);
    virtual ~QPageSetupDialog();
    virtual void setVisible(bool visible);
    virtual int exec() /PostHook=__pyQtPostEventLoopHook__,PreHook=__pyQtPreEventLoopHook__,PyName=exec_,ReleaseGIL/;
%MethodCode
        // Transfer ownership back to Python (a modal dialog will probably have the
        // main window as it's parent).  This means the Qt dialog will be deleted when
        // the Python wrapper is garbage collected.  Although this is a little
        // inconsistent, it saves having to code it explicitly to avoid the memory
        // leak.
        sipTransferBack(sipSelf);
        
        Py_BEGIN_ALLOW_THREADS
        sipRes = sipSelfWasArg ? sipCpp->QPageSetupDialog::exec()
                               : sipCpp->exec();
        Py_END_ALLOW_THREADS
%End

    virtual int exec() /PostHook=__pyQtPostEventLoopHook__,PreHook=__pyQtPreEventLoopHook__,ReleaseGIL/;
%MethodCode
        // Transfer ownership back to Python (a modal dialog will probably have the
        // main window as it's parent).  This means the Qt dialog will be deleted when
        // the Python wrapper is garbage collected.  Although this is a little
        // inconsistent, it saves having to code it explicitly to avoid the memory
        // leak.
        sipTransferBack(sipSelf);
        
        Py_BEGIN_ALLOW_THREADS
        sipRes = sipSelfWasArg ? sipCpp->QPageSetupDialog::exec()
                               : sipCpp->exec();
        Py_END_ALLOW_THREADS
%End

    virtual void open();
    void open(QObject *receiver, SIP_PYOBJECT member /TypeHint="QT_SLOT"/);
%MethodCode
        const char *slot = pyqt4_qtgui_get_slot(a1);
        
        if (slot)
        {
            Py_BEGIN_ALLOW_THREADS
            sipCpp->open(a0, slot);
            Py_END_ALLOW_THREADS
        }
        else
        {
            sipError = sipBadCallableArg(1, a1);
        }
%End

    void open(SIP_PYOBJECT slot /TypeHint="PYQT_SLOT"/);
%MethodCode
        QObject *receiver;
        QByteArray slot_signature;
        
        if ((sipError = pyqt4_qtgui_get_connection_parts(a0, 0, "()", false, &receiver, slot_signature)) == sipErrorNone)
        {
            Py_BEGIN_ALLOW_THREADS
            sipCpp->open(receiver, slot_signature.constData());
            Py_END_ALLOW_THREADS
        }
        else if (sipError == sipErrorContinue)
        {
            sipError = sipBadCallableArg(0, a0);
        }
%End

    virtual void done(int result);
    QPrinter *printer();
};

%End
%End
