class DossierFields {
  static const List<String> values = [
    id,
    numero,
    utilisateur,
    sigle,
    date,
    observation,
    statut,
  ];
  static const String tableName = 'dossiers';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String intType = 'INTEGER NOT NULL';

  static const String id = '_id';
  static const String numero = 'numero';
  static const String utilisateur = 'utilisateur';
  static const String sigle = 'sigle';
  static const String date = 'date';
  static const String observation = 'observation';
  static const String statut = 'statut';
}
