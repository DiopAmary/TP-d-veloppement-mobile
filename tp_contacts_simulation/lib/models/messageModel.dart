class Message {
  int id;
  int contactID;
  DateTime date;
  String content;
  String type;
  bool seleted;

  Message(
      {this.id,
      this.contactID,
      this.content,
      this.date,
      this.type,
      this.seleted});
}
