//app.js
App({
  onLaunch: function () {
    //  设置请求url
    wx.setStorageSync('baseUrl', 'http://localhost:8080')
    
    this.getUserInfo()  
  },

  /**
   * 获取
   */
  getUserInfo: function(){
    wx.login({
      success: (res) => {
        if(res.code){
//        保存 临时登录凭证
          wx.setStorageSync('login_code', res.code)
        }
      }
    })
  },
  globalData: {
    userInfo: null
  }
})