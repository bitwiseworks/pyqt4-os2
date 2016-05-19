// This is the initialisation support code for the QtCore module.
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

#include "qpycore_chimera.h"
#include "qpycore_qobject_helpers.h"
#include "qpycore_shared.h"
#include "qpycore_sip.h"
#include "qpycore_types.h"


// Perform any required initialisation.
void qpycore_init()
{
    // Initialise the meta-type.
    qpycore_pyqtWrapperType_Type.tp_base = sipWrapperType_Type;

    if (PyType_Ready(&qpycore_pyqtWrapperType_Type) < 0)
        Py_FatalError("PyQt4.QtCore: Failed to initialise pyqtWrapperType type");

    // Register the meta-type.
    if (sipRegisterPyType((PyTypeObject *)&qpycore_pyqtWrapperType_Type) < 0)
        Py_FatalError("PyQt4.QtCore: Failed to register pyqtWrapperType type");

    // Export the helpers.
    sipExportSymbol("qtcore_qt_metaobject",
            (void *)qpycore_qobject_metaobject);
    sipExportSymbol("qtcore_qt_metacall", (void *)qpycore_qobject_qt_metacall);
    sipExportSymbol("qtcore_qt_metacast", (void *)qpycore_qobject_qt_metacast);
    sipExportSymbol("qpycore_qobject_sender", (void *)qpycore_qobject_sender);
    sipExportSymbol("qpycore_qobject_receivers",
            (void *)qpycore_qobject_receivers);

    sipExportSymbol("qpycore_ArgvToC", (void *)qpycore_ArgvToC);
    sipExportSymbol("qpycore_UpdatePyArgv", (void *)qpycore_UpdatePyArgv);

    sipExportSymbol("qpycore_pyqtsignal_get_parts",
            (void *)qpycore_pyqtsignal_get_parts);
    sipExportSymbol("qpycore_pyqtslot_get_parts",
            (void *)qpycore_pyqtslot_get_parts);

    sipExportSymbol("qpycore_qvariant_value", (void *)qpycore_qvariant_value);

    sipExportSymbol("qpycore_register_to_pyobject",
            (void *)Chimera::registerToPyObject);
    sipExportSymbol("qpycore_register_to_qvariant",
            (void *)Chimera::registerToQVariant);
    sipExportSymbol("qpycore_register_to_qvariant_data",
            (void *)Chimera::registerToQVariantData);
}
