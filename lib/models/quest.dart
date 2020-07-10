class Quest {
  //atributos
  String _id;
  String _nomeQuest;
  String _descQuest;
  int _quantidade;
  int _situacao;

  //construtor
  Quest(String idDocumento, String nome, String desc, int qtd, int situacao);

  //getters
  String get id => _id;
  String get nomeQuest => _nomeQuest;
  String get descQuest => _descQuest;
  int get quantidade => _quantidade;
  int get situacao => _situacao;

  Quest.map(dynamic obj) {
    this._id = obj['id'];
    this._nomeQuest = obj['nomeQuest'];
    this._descQuest = obj['descQuest'];
    this._quantidade = obj['quantidade'];
    this._situacao = obj['situacao'];
  }

  //Converter os dados para um Mapa
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map["id"] = _id;
    }
    map["nomeQuest"] = _nomeQuest;
    map["descQuest"] = _descQuest;
    map["quantidade"] = _quantidade;
    map["situacao"] = _situacao;
    return map;
  }

  //Converter um Mapa para o modelo de dados
  Quest.fromMap(Map<String, dynamic> map, String id) {
    this._id = id ?? '';
    this._nomeQuest = map["nomeQuest"];
    this._descQuest = map["descQuest"];
    this._quantidade = map["quantidade"];
    this._situacao = map["situacao"];
  }
}
