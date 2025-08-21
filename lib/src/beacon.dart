enum ProximityState {
  //約1m未満
  immediate('1', 'immediate'),
  //約1m〜3m
  near('2', 'near'),
  //検出は可能だが精度が低い(必ずしも遠いというわけではない)
  far('3', 'far'),
  //判断不可(測距が始まってすぐか測定値が不十分など)
  unknown('0', 'unknown');

  const ProximityState(this.id, this.name);

  final String id;
  final String name;
}

ProximityState getProximityState(double val) {
  if (val < 1) {
    return ProximityState.immediate;
  } else if (val < 3) {
    return ProximityState.near;
  } else {
    return ProximityState.far;
  }
}

enum MonitorState{
  Exit(0, 'Exit'),
  Enter(1, 'Enter');

  const MonitorState(this.id, this.name);

  ///id
  final int id;
  //name
  final String name;
}