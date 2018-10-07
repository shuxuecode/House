function formatTime(date) {
  var year = date.getFullYear()
  var month = date.getMonth() + 1
  var day = date.getDate()

  var hour = date.getHours()
  var minute = date.getMinutes()
  var second = date.getSeconds()


  return [year, month, day].map(formatNumber).join('/') + ' ' + [hour, minute, second].map(formatNumber).join(':')
}

function formatNumber(n) {
  n = n.toString()
  return n[1] ? n : '0' + n
}

function getDistance(lat1, lng1, lat2, lng2) {
  var radLat1 = lat1 * Math.PI / 180.0
  var radLat2 = lat2 * Math.PI / 180.0
  var a = radLat1 - radLat2
  var b = (lng1 * Math.PI / 180.0) - (lng2 * Math.PI / 180.0)
  var s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2) + Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(b / 2), 2)))
  s = s * 6378.137
  s = Math.round(s * 1000)
  if (s > 1000) {
    s /= 1000
    return Math.round(s * 10) / 10 + 'km';
  }
  return Math.round(s) + 'm';
}

module.exports = {
  formatTime: formatTime,
  getDistance: getDistance
}
