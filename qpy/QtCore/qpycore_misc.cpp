// This contains the implementation of various odds and ends.
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


#include <Python.h>

#include "qpycore_misc.h"
#include "qpycore_types.h"


// Return true if the given type (which must be a class) was wrapped for PyQt4.
bool qpycore_is_pyqt4_class(const sipTypeDef *td)
{
    return PyType_IsSubtype(Py_TYPE(sipTypeAsPyTypeObject(td)),
            &qpycore_pyqtWrapperType_Type);
}


#if PY_MAJOR_VERSION >= 3
// Python v3 doesn't have the Unicode equivalent of Python v2's
// PyString_ConcatAndDel().
void qpycore_Unicode_ConcatAndDel(PyObject **string, PyObject *newpart)
{
    PyObject *old = *string;

    if (old)
    {
        if (newpart)
            *string = PyUnicode_Concat(old, newpart);
        else
            *string = 0;

        Py_DECREF(old);
    }

    Py_XDECREF(newpart);
}
#endif


// Convert a Python argv list to a conventional C argc count and argv array.
char **qpycore_ArgvToC(PyObject *argvlist, int &argc)
{
    argc = PyList_GET_SIZE(argvlist);

    // Allocate space for two copies of the argument pointers, plus the
    // terminating NULL.
    char **argv = new char *[2 * (argc + 1)];

    // Convert the list.
    for (int a = 0; a < argc; ++a)
    {
        PyObject *arg_obj = PyList_GET_ITEM(argvlist, a);
        char *arg;

        if (PyUnicode_Check(arg_obj))
        {
            QByteArray ba_arg = qpycore_PyObject_AsQString(arg_obj).toLocal8Bit();
            arg = qstrdup(ba_arg.constData());
        }
        else if (SIPBytes_Check(arg_obj))
        {
            arg = qstrdup(SIPBytes_AS_STRING(arg_obj));
        }
        else
        {
            arg = const_cast<char *>("invalid");
        }

        argv[a] = argv[a + argc + 1] = arg;
    }

    argv[argc + argc + 1] = argv[argc] = NULL;

    return argv;
}


// Remove arguments from the Python argv list that have been removed from the
// C argv array.
void qpycore_UpdatePyArgv(PyObject *argvlist, int argc, char **argv)
{
    for (int a = 0, na = 0; a < argc; ++a)
    {
        // See if it was removed.
        if (argv[na] == argv[a + argc + 1])
            ++na;
        else
            PyList_SetSlice(argvlist, na, na + 1, 0);
    }
}
