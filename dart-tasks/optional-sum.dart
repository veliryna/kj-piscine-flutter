int optionalSum(int first, int second, [int? third]) {
  if (third != null) {
    return first+second+third;
  } else {
    return first+second;
  }
}
