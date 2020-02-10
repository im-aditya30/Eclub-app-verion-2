class NewItems{
  String _name;
  String _picture;
  String _quantities;
  String _about;
  String _description;
  String _sheetId;
  String _action = "insert";
  NewItems(this._name,this._picture,this._quantities,this._about,this._description,this._sheetId);

  String toParams() => 
  "?name=$_name&picture=$_picture&quantities=$_quantities&about=$_about&description=$_description&sheetId=$_sheetId&action=$_action";
}