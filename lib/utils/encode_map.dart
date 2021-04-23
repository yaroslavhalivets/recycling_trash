T? encodeMap<T, S>(S key, Map<S, T> map) {
  if (map.containsKey(key)) {
    return map[key];
  }
  return null;
}
