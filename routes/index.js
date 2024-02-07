const express = require('express');
const router = express.Router();
const pool = require('../bin/DBconnection');

// Ruta principal
router.get('/lista', function (req, res, next) {
  pool.getConnection((err, conexion) => {
    if (err) {
      res.send('Error de conexion: ' + err.message);
    } else {
      const sql = "SELECT * FROM alumnos;";

      conexion.query(sql, (err, resultado) => {
        if (err) {
          res.send('error en consulta:' + err.message);
        } else {
          res.render('index', { datos: resultado });
        }
      });

      conexion.release();
    }
  });
});

router.get('/', function (req, res, next) {
  res.render('principal'); // Renderiza el archivo principal.ejs
});

router.get('/asis', function (req, res, next) {
  pool.getConnection((err, conexion) => {
    if (err) {
      res.send('Error de conexión: ' + err.message);
    } else {
      const sql = "SELECT asistencia.id_asistencia, CONCAT(alumnos.nombre, ' ', alumnos.apellido_paterno, ' ', alumnos.apellido_materno) AS nombre_alumno, asistencia.fecha, asistencia.hora, asistencia.estado FROM asistencia INNER JOIN alumnos ON asistencia.id_alumno = alumnos.id_alumno;";

      conexion.query(sql, (err, resultado) => {
        if (err) {
          res.send('Error en consulta: ' + err.message);
        } else {
          res.render('asistencia', { asistencias: resultado });
        }
      });

      conexion.release();
    }
  });
});




// Ruta para mostrar el formulario de envío o edición
router.get('/enviar', (req, res) => {
  const idAlumno = req.query.idAlumno;

  if (idAlumno) {
    // Si se proporciona un ID de alumno, obtenemos los detalles de ese alumno
    pool.getConnection((err, conexion) => {
      if (err) {
        res.send('Error de conexión: ' + err.message);
      } else {
        const sql = "SELECT * FROM alumnos WHERE id_alumno = ?;";
        conexion.query(sql, [idAlumno], (err, resultado) => {
          if (err) {
            res.send('Error en la consulta:' + err.message);
          } else {
            // Renderizar la vista enviar con detalles del alumno para edición
            res.render('enviar', { idAlumno: idAlumno, alumno: resultado[0] });
          }
        });
        conexion.release();
      }
    });
  } else {
    // Si no se proporciona un ID de alumno, simplemente mostramos el formulario vacío
    res.render('enviar');
  }
});

// Ruta para mostrar el formulario de envío o edición
router.get('/nuevo', (req, res) => {
  const idAlumno = req.query.idAlumno;

  if (idAlumno) {
    // Si se proporciona un ID de alumno, obtenemos los detalles de ese alumno
    pool.getConnection((err, conexion) => {
      if (err) {
        res.send('Error de conexión: ' + err.message);
      } else {
        const sql = "SELECT * FROM alumnos WHERE id_alumno = ?;";
        conexion.query(sql, [idAlumno], (err, resultado) => {
          if (err) {
            res.send('Error en la consulta:' + err.message);
          } else {
            // Renderizar la vista enviar con detalles del alumno para edición
            res.render('nuevo', { idAlumno: idAlumno, alumno: resultado[0] });
          }
        });
        conexion.release();
      }
    });
  } else {
    // Si no se proporciona un ID de alumno, simplemente mostramos el formulario vacío
    res.render('nuevo');
  }
});

// Ruta para manejar el envío o edición del formulario
router.post('/operacion', (req, res) => {
  console.log(req.body); // Verifica si accion y otros datos están presentes en req.body

  const { accion, idAlumno, nombre, apellidoPaterno, apellidoMaterno, matricula, email, telefono, estado } = req.body;

  switch (accion) {
    case 'agregar':
      guardarAlumno(req.body, res);
      break;
    case 'guardar':
      if (idAlumno) {
        modificarAlumno(idAlumno, req.body, res);
      } else {
        guardarAlumno(req.body, res);
      }
      break;
    case 'eliminar':
      eliminarAlumno(idAlumno, res);
      break;
    case 'cancelar': // Agregamos el caso 'cancelar' para manejar la acción de "Volver"
      res.redirect('/');
      break;
    default:
      res.status(400).send('Accion no válida');
  }
});

function guardarAlumno(data, res) {
  const { idAlumno, nombre, apellidoPaterno, apellidoMaterno, matricula, email, telefono, estado } = data;
  const sql = 'INSERT INTO alumnos (id_alumno, nombre, apellido_paterno, apellido_materno, matricula, email, telefono, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';
  const values = [idAlumno, nombre, apellidoPaterno, apellidoMaterno, matricula, email, telefono, estado];

  pool.query(sql, values, (err, result) => {
    if (err) {
      console.error('Error al insertar datos en la base de datos:', err);
      res.status(500).send('Error interno del servidor');
    } else {
      console.log('Datos insertados correctamente en la base de datos');
      res.redirect('/');
    }
  });
}

function modificarAlumno(idAlumno, data, res) {
  const { nombre, apellidoPaterno, apellidoMaterno, matricula, email, telefono, estado } = data;

  const sql = 'UPDATE alumnos SET nombre = ?, apellido_paterno = ?, apellido_materno = ?, matricula = ?, email = ?, telefono = ?, estado = ? WHERE id_alumno = ?';
  const values = [nombre, apellidoPaterno, apellidoMaterno, matricula, email, telefono, estado, idAlumno];

  pool.query(sql, values, (err, result) => {
    if (err) {
      console.error('Error al actualizar datos en la base de datos:', err);
      res.status(500).send('Error interno del servidor');
    } else {
      console.log('Datos actualizados correctamente en la base de datos');
      res.redirect('/');
    }
  });
}

function eliminarAlumno(idAlumno, res) {
  const sql = 'DELETE FROM alumnos WHERE id_alumno = ?';

  pool.query(sql, [idAlumno], (err, result) => {
    if (err) {
      console.error('Error al eliminar datos de la base de datos:', err);
      res.status(500).send('Error interno del servidor');
    } else {
      console.log('Datos eliminados correctamente de la base de datos');
      res.redirect('/');
    }
  });
}

module.exports = router;
