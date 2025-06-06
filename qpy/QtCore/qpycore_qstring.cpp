// This is the support for QString.
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

#include <Python.h>
#include <string.h>

#include <QString>
#include <QTextCodec>
#include <QVector>

#include "qpycore_sip.h"

// Work out if we should enable PEP 393 support.  This is complicated by the
// broken LLVM that XCode v4 installs.
#if PY_VERSION_HEX >= 0x03030000
#if defined(Q_OS_MAC)
#if !defined(__llvm__) || defined(__clang__)
// Python v3.3 on a Mac using either g++ or Clang, but not LLVM.
#define PYQT_PEP_393
#endif
#else
// Python v3.3 on a non-Mac.
#define PYQT_PEP_393
#endif
#endif

#if PY_VERSION_HEX > 0x03090000
static int
as_read_buffer(PyObject *obj, const void **buffer, Py_ssize_t *buffer_len)
{
    Py_buffer view;

    if (obj == NULL || buffer == NULL || buffer_len == NULL) {
        return -1;
    }
    if (PyObject_GetBuffer(obj, &view, PyBUF_SIMPLE) != 0)
        return -1;

    *buffer = view.buf;
    *buffer_len = view.len;
    PyBuffer_Release(&view);
    return 0;
}

static int
PyObject_AsCharBuffer(PyObject *obj,
                      const char **buffer,
                      Py_ssize_t *buffer_len)
{
    return as_read_buffer(obj, (const void **)buffer, buffer_len);
}
#endif

// Convert a QString to a Python Unicode object.
PyObject *qpycore_PyObject_FromQString(const QString &qstr)
{
    PyObject *obj;

#if defined(PYQT_PEP_393)
    // We have to work out exactly which kind to use.  We assume ASCII while we
    // are checking so that we only go through the string once in the most
    // common case.  Note that we can't use PyUnicode_FromKindAndData() because
    // it doesn't handle surrogates in UCS2 strings.
    int qt_len = qstr.length();

    if ((obj = PyUnicode_New(qt_len, 0x007f)) == NULL)
        return NULL;

    int kind = PyUnicode_KIND(obj);
    void *data = PyUnicode_DATA(obj);
    const QChar *qch = qstr.constData();

    for (int qt_i = 0; qt_i < qt_len; ++qt_i)
    {
        ushort uch = qch->unicode();

        if (uch > 0x007f)
        {
            // This is useless.
            Py_DECREF(obj);

            // Work out what kind we really need and what the Python length
            // should be.
            Py_UCS4 maxchar = 0x00ff;

            int py_len = qt_len;

            while (qt_i < qt_len)
            {
                uch = qch->unicode();

                if (uch > 0x00ff)
                {
                    if (maxchar == 0x00ff)
                        maxchar = 0x00ffff;

                    // See if this is a surrogate pair.  Note that we cannot
                    // trust that the QString is terminated by a null QChar.
                    if (qch->isHighSurrogate() && qt_i + 1 < qt_len && (qch + 1)->isLowSurrogate())
                    {
                        maxchar = 0x10ffff;
                        --py_len;
                        ++qch;
                        ++qt_i;
                    }
                }

                ++qch;
                ++qt_i;
            }

            // Create the correctly sized object.
            if ((obj = PyUnicode_New(py_len, maxchar)) == NULL)
                return NULL;

            kind = PyUnicode_KIND(obj);
            data = PyUnicode_DATA(obj);
            qch = qstr.constData();

            int qt_i2 = 0;

            for (int py_i = 0; py_i < py_len; ++py_i)
            {
                Py_UCS4 py_ch;

                if (qch->isHighSurrogate() && qt_i2 + 1 < qt_len && (qch + 1)->isLowSurrogate())
                {
                    py_ch = QChar::surrogateToUcs4(*qch, *(qch + 1));
                    ++qt_i2;
                    ++qch;
                }
                else
                {
                    py_ch = qch->unicode();
                }

                ++qt_i2;
                ++qch;

                PyUnicode_WRITE(kind, data, py_i, py_ch);
            }

            break;
        }

        ++qch;

        PyUnicode_WRITE(kind, data, qt_i, uch);
    }
#elif defined(Py_UNICODE_WIDE)
#if QT_VERSION >= 0x040200
    QVector<uint> ucs4 = qstr.toUcs4();

    if ((obj = PyUnicode_FromUnicode(NULL, ucs4.size())) == NULL)
        return NULL;

    memcpy(PyUnicode_AS_UNICODE(obj), ucs4.constData(),
            ucs4.size() * sizeof (Py_UNICODE));
#else
    // Note that this doesn't handle code points greater than 0xffff.  It could
    // but it's only an issue for old versions of Qt.

    if ((obj = PyUnicode_FromUnicode(NULL, qstr.length())) == NULL)
        return NULL;

    Py_UNICODE *pyu = PyUnicode_AS_UNICODE(obj);

    for (int i = 0; i < qstr.length(); ++i)
        *pyu++ = (qstr.at(i)).unicode();
#endif
#else
    if ((obj = PyUnicode_FromUnicode(NULL, qstr.length())) == NULL)
        return NULL;

    memcpy(PyUnicode_AS_UNICODE(obj), qstr.utf16(),
            qstr.length() * sizeof (Py_UNICODE));
#endif

    return obj;
}


// Convert a Python Unicode object to a QString.
QString qpycore_PyObject_AsQString(PyObject *obj)
{
#if defined(PYQT_PEP_393)
    if (PyUnicode_READY(obj) < 0)
        return QString();

    SIP_SSIZE_T len = PyUnicode_GET_LENGTH(obj);

    switch (PyUnicode_KIND(obj))
    {
    case PyUnicode_1BYTE_KIND:
        return QString::fromLatin1((char *)PyUnicode_1BYTE_DATA(obj), len);

    case PyUnicode_2BYTE_KIND:
        // The (QChar *) cast should be safe.
        return QString((QChar *)PyUnicode_2BYTE_DATA(obj), len);

    case PyUnicode_4BYTE_KIND:
#if QT_VERSION >= 0x040200
        return QString::fromUcs4(PyUnicode_4BYTE_DATA(obj), len);
#else
        // Note that this doesn't handle code points greater than 0xffff.  It
        // could but it's only an issue for old versions of Qt.

        QString qstr;

        Py_UCS4 *ucode = PyUnicode_4BYTE_DATA(obj);

        for (SIP_SSIZE_T i = 0; i < len; ++i)
            qstr.append((uint)ucode[i]);

        return qstr;
#endif
    }

    return QString();
#elif defined(Py_UNICODE_WIDE)
#if QT_VERSION >= 0x040200
    return QString::fromUcs4((const uint *)PyUnicode_AS_UNICODE(obj),
            PyUnicode_GET_SIZE(obj));
#else
    // Note that this doesn't handle code points greater than 0xffff.  It could
    // but it's only an issue for old versions of Qt.

    QString qstr;

    Py_UNICODE *ucode = PyUnicode_AS_UNICODE(obj);
    SIP_SSIZE_T len = PyUnicode_GET_SIZE(obj);

    for (SIP_SSIZE_T i = 0; i < len; ++i)
        qstr.append((uint)ucode[i]);

    return qstr;
#endif
#else
    return QString::fromUtf16((const ushort *)PyUnicode_AS_UNICODE(obj),
            PyUnicode_GET_SIZE(obj));
#endif
}


#if !defined(QT_DEPRECATED_SINCE)
#define QT_DEPRECATED_SINCE(m, n)   1
#endif
#if QT_DEPRECATED_SINCE(5, 0)
// Convert a Python unicode/string/bytes object to a character string encoded
// according to the given encoding.  Update the object with a new reference to
// the object that owns the data.
const char *qpycore_encode(PyObject **s, QCoreApplication::Encoding encoding)
{
    PyObject *obj = *s;
    const char *es = 0;
    SIP_SSIZE_T sz;

    if (PyUnicode_Check(obj))
    {
        if (encoding == QCoreApplication::UnicodeUTF8)
        {
            obj = PyUnicode_AsUTF8String(obj);
        }
        else
        {
            QTextCodec *codec = QTextCodec::codecForTr();

            if (codec)
            {
                // Use the Qt codec to get to a byte string, and then to a
                // Python object.
                QString qs = qpycore_PyObject_AsQString(obj);
                QByteArray ba = codec->fromUnicode(qs);

#if PY_MAJOR_VERSION >= 3
                obj = PyBytes_FromStringAndSize(ba.constData(), ba.size());
#else
                obj = PyString_FromStringAndSize(ba.constData(), ba.size());
#endif
            }
            else
            {
                obj = PyUnicode_AsLatin1String(obj);
            }
        }

        if (obj)
        {
#if PY_MAJOR_VERSION >= 3
            es = PyBytes_AS_STRING(obj);
#else
            es = PyString_AS_STRING(obj);
#endif
        }
    }
#if PY_MAJOR_VERSION >= 3
    else if (PyBytes_Check(obj))
    {
        es = PyBytes_AS_STRING(obj);
        Py_INCREF(obj);
    }
#else
    else if (PyString_Check(obj))
    {
        es = PyString_AS_STRING(obj);
        Py_INCREF(obj);
    }
#endif
    else if (PyObject_AsCharBuffer(obj, &es, &sz) >= 0)
    {
        Py_INCREF(obj);
    }

    if (es)
    {
        *s = obj;
    }
    else
    {
        PyErr_Format(PyExc_UnicodeEncodeError,
                "unable to convert '%s' to requested encoding",
                Py_TYPE(*s)->tp_name);
    }

    return es;
}
#endif
