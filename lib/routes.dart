import 'package:shelf_router/shelf_router.dart';
import 'controllers/persons.dart';

Router routes() {
  final router = Router();

	// # personsController
  router.get('/persons', getAll);
  router.get('/person/<id>', getPersonByID);
  router.post('/person/create', create);
  router.delete('/person/delete/<id>', delete);
  router.put('/person/update/<id>', update);

  return router;
}
