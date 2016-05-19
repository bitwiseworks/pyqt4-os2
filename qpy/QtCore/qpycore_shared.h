// This defines the interfaces to various odd and ends that are used internally
// by this library and called from handwritten code.
//
// Copyright (c) 2015 Riverbank Computing Limited <info@riverbankcomputing.com>
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


#ifndef _QPYCORE_SHARED_H
#define _QPYCORE_SHARED_H


#include <Python.h>

#include <QtGlobal>
#include <QByteArray>

#include "qpycore_namespace.h"


QT_BEGIN_NAMESPACE
class QObject;
class QVariant;
QT_END_NAMESPACE


char **qpycore_ArgvToC(PyObject *argvlist, int &argc);
void qpycore_UpdatePyArgv(PyObject *argvlist, int argc, char **argv);

const char *qpycore_pyqtsignal_get_parts(PyObject *sig_obj, QObject **qtx);
QByteArray qpycore_pyqtslot_get_parts(PyObject *callable, QObject **qrx);

PyObject *qpycore_qvariant_value(QVariant &value, PyObject *type);

#endif
